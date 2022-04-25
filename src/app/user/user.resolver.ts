// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import * as bcrypt from 'bcrypt';
import { parsePhoneNumber } from 'libphonenumber-js';
import { Args, Mutation, Query, Resolver } from '@nestjs/graphql';
import {
  AccessToken,
  OneTimePasswordType,
  PrismaClient,
  PrismaPromise,
  User as UserInterface,
} from '@prisma/client';
import { Auth } from 'src/shared/auth';
import { OneTimePasswordService } from 'src/app/one-time-password';
import { UserFindManyArgs } from './dto/user-find-many.args';
import { UserWhereUniqueInput } from './dto/user-where-unique.input';
import { User } from './entities/user.entity';
import { UserProfileService } from './profile/user-profile.service';
import { UserService } from './user.service';
import {
  UpdateUserSecurityArgs,
  UserSecurityFields,
} from './dto/update-user-security.args';
import { AccountSecurityHealthResult } from './entities/account_security_health.entity';

@Resolver(() => User)
export class UserResolver {
  constructor(
    private readonly userService: UserService,
    private readonly userProfileService: UserProfileService,
    private readonly otpService: OneTimePasswordService,
    private readonly prisma: PrismaClient,
  ) {}

  @Query(() => [AccountSecurityHealthResult], {
    description: 'Account Security Health Check',
  })
  @Auth.must()
  async accountSecurityHealth(
    @Auth.accessToken() { userId }: AccessToken,
  ): Promise<AccountSecurityHealthResult[]> {
    const { password, email, phone } = await this.prisma.user.findUnique({
      select: { password: true, email: true, phone: true },
      where: { id: userId },
      rejectOnNotFound: true,
    });

    return [
      AccountSecurityHealthResult.fromPassword(password),
      AccountSecurityHealthResult.fromEmail(email),
      AccountSecurityHealthResult.fromPhone(phone),
    ];
  }

  /**
   * Find a user by unique where input.
   * @param where User where unique input
   * @returns User
   */
  @Query(() => User, {
    description: 'Find a user by unique where',
    nullable: true,
  })
  async user(
    @Args({ name: 'where', type: () => UserWhereUniqueInput })
    where: UserWhereUniqueInput,
  ) {
    return this.prisma.user.findUnique({ where, rejectOnNotFound: false });
  }

  /**
   * Find many users.
   * @param args User find many args.
   * @returns User[]
   */
  @Query(() => [User], {
    nullable: 'items',
    description: 'Find users',
  })
  async users(@Args({ type: () => UserFindManyArgs }) args: UserFindManyArgs) {
    return this.prisma.user.findMany(args);
  }

  /**
   * Update current username.
   * @param username New username.
   * @param accessToken @Auth.accessToken()
   * @returns Updated user.
   */
  @Mutation(() => User)
  @Auth.must()
  async updateUsername(
    @Args({ name: 'username', type: () => String }) username: string,
    @Auth.accessToken() accessToken: AccessToken,
  ) {
    return this.userService.updateUsername(accessToken.userId, username);
  }

  /**
   * Update user security.
   * @param args User new security args.
   * @param accessToken @Auth.accessToken()
   * @returns User
   */
  @Mutation(() => User)
  @Auth.must()
  async updateUserSecurity(
    @Args({ type: () => UpdateUserSecurityArgs }) args: UpdateUserSecurityArgs,
    @Auth.accessToken() { userId }: AccessToken,
  ) {
    const user: UserInterface = await this.prisma.user.findUnique({
      where: { id: userId },
      rejectOnNotFound: true,
    });
    let field: 'password' | 'email' | 'phone';

    // Check Verify field has set.
    if (args.verifyField === UserSecurityFields.EMAIL && !user.email) {
      field = 'email';
      throw new Error('You have not bind email.');
    } else if (args.verifyField === UserSecurityFields.PHONE && !user.phone) {
      field = 'phone';
      throw new Error('You have not bind phone.');
    } else if (
      args.verifyField === UserSecurityFields.PASSWORD &&
      !user.password
    ) {
      field = 'password';
      throw new Error('You have not set password.');
    }

    // Check need OTP.
    if (args.field !== UserSecurityFields.PASSWORD && !args.otp) {
      throw new Error('Please enter OTP.');
    }

    // Check Phone format.
    if (args.field === UserSecurityFields.PHONE) {
      const phone = parsePhoneNumber(args.value);
      if (!phone.isValid()) {
        throw new Error('Phone format is invalid.');
      }

      args.value = phone.format('E.164');
    }

    // Check new field user is exist.
    if (args.field !== UserSecurityFields.PASSWORD) {
      const field = args.field === UserSecurityFields.EMAIL ? 'email' : 'phone';
      const exists = await this.prisma.user.findUnique({
        where: { [field]: args.value },
        rejectOnNotFound: false,
      });
      if (exists && exists.id !== user.id) {
        throw new Error(`${args.value} is already in use.`);
      }
    }

    // OTP verify and create delete callback.
    let onVerifyOtpDelete: () => Promise<any> = () => Promise.resolve();
    if (args.verifyField !== UserSecurityFields.PASSWORD) {
      const fieldValue =
        args.verifyField === UserSecurityFields.EMAIL
          ? user.email!
          : user.phone!;
      onVerifyOtpDelete = await this.otpService.verify(
        args.verifyField === UserSecurityFields.EMAIL
          ? OneTimePasswordType.EMAIL
          : OneTimePasswordType.SMS,
        fieldValue,
        args.verifyValue,
      );
    }

    // Check user password equal user.password.
    if (args.verifyField === UserSecurityFields.PASSWORD) {
      const isEqual = await bcrypt.compare(args.verifyValue, user.password!);
      if (!isEqual) {
        throw new Error('Password is incorrect.');
      }
    }

    // Check new security OTP verify and create delete callback.
    let onNewSecurityOtpDelete: () => Promise<any> = () => Promise.resolve();
    if (args.field !== UserSecurityFields.PASSWORD) {
      onNewSecurityOtpDelete = await this.otpService.verify(
        args.field === UserSecurityFields.EMAIL
          ? OneTimePasswordType.EMAIL
          : OneTimePasswordType.SMS,
        args.value,
        args.otp!,
      );
    }

    let value = args.value;
    if (args.field === UserSecurityFields.PASSWORD) {
      if (user.password) {
        const oldPasswordIsEqual = await bcrypt.compare(
          args.value,
          user.password!,
        );
        if (oldPasswordIsEqual) {
          throw new Error('New password is same as old password.');
        }
      }

      value = await bcrypt.hash(args.value, await bcrypt.genSalt());
    }

    // Update user security.
    const response = await this.userService.updateUserSecurity(
      user,
      args.field,
      value,
    );

    // Delete all OTPs.
    await Promise.all([onVerifyOtpDelete(), onNewSecurityOtpDelete()]);

    return response;
  }
}
