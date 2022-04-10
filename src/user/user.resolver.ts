// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import * as bcrypt from 'bcrypt';
import { parsePhoneNumber } from 'libphonenumber-js';
import {
  Args,
  Int,
  Mutation,
  Parent,
  Query,
  ResolveField,
  Resolver,
} from '@nestjs/graphql';
import {
  AccessToken,
  OneTimePasswordType,
  PrismaClient,
  User as _User,
  Moment as _Moment,
  Comment as _Comment,
  PrismaPromise,
} from '@prisma/client';
import { Auth } from 'src/auth';
import { OneTimePasswordService } from 'src/one-time-password';
import { UserFindManyArgs } from './dto/user-find-many.args';
import { UserWhereUniqueInput } from './dto/user-where-unique.input';
import { User } from './entities/user.entity';
import { UserProfile } from './profile/entities/user-profile.entity';
import { UserProfileService } from './profile/user-profile.service';
import { UserService } from './user.service';
import {
  UpdateUserSecurityArgs,
  UserSecurityFields,
} from './dto/update-user-security.args';
import { Moment } from 'src/moment/entities/moment.entity';
import { Comment } from 'src/comment/entities/comment.entity';

@Resolver(() => User)
export class UserResolver {
  constructor(
    private readonly userService: UserService,
    private readonly userProfileService: UserProfileService,
    private readonly otpService: OneTimePasswordService,
    private readonly prisma: PrismaClient,
  ) {}

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
    const user: _User = await this.prisma.user.findUnique({
      where: { id: userId },
      rejectOnNotFound: true,
    });
    let field: string;

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
    if (args.verifyField !== UserSecurityFields.PASSWORD && !args.otp) {
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

    // Update user security.
    const response = await this.userService.updateUserSecurity(
      user,
      args.field,
      args.value,
    );

    // Delete all OTPs.
    await Promise.all([onVerifyOtpDelete(), onNewSecurityOtpDelete()]);

    return response;
  }

  /**
   * Resolve user profile field.
   * @param user @Parent()
   * @returns UserProfile
   */
  @ResolveField(() => UserProfile)
  async profile(@Parent() user: User) {
    if (!user.profile) {
      return this.userProfileService.resolve(user.id);
    }

    return user.profile;
  }

  @ResolveField(() => [Moment])
  moments(
    @Parent() { id }: _User,
    @Args({ name: 'take', type: () => Int, nullable: true, defaultValue: 15 })
    take: number = 15,
    @Args({ name: 'skip', type: () => Int, nullable: true }) skip?: number,
  ): PrismaPromise<_Moment[]> {
    return this.prisma.moment.findMany({
      where: { userId: id },
      orderBy: { createdAt: 'desc' },
      take,
      skip,
    });
  }

  @ResolveField(() => [Moment])
  async likedMoments(
    @Parent() { id }: _User,
    @Args({ name: 'take', type: () => Int, nullable: true, defaultValue: 15 })
    take: number = 15,
    @Args({ name: 'skip', type: () => Int, nullable: true }) skip?: number,
  ): Promise<_Moment[]> {
    const results = await this.prisma.userLikeOnMoment.findMany({
      select: { moment: true },
      where: { userId: id },
      orderBy: { createdAt: 'desc' },
      take,
      skip,
    });

    return results.map(({ moment }) => moment);
  }

  @ResolveField(() => [Comment])
  comments(
    @Parent() { id }: _User,
    @Args({ name: 'take', type: () => Int, nullable: true, defaultValue: 15 })
    take: number = 15,
    @Args({ name: 'skip', type: () => Int, nullable: true }) skip?: number,
  ): PrismaPromise<_Comment[]> {
    return this.prisma.comment.findMany({
      where: { userId: id },
      orderBy: { createdAt: 'desc' },
      take,
      skip,
    });
  }

  @ResolveField('email', () => String, { nullable: true })
  @Auth.nullable()
  resolveEmail(
    @Parent() user: _User,
    @Auth.accessToken() accessToken: AccessToken,
  ): string | null | undefined {
    if (!user.email) return;
    if (!accessToken) return;
    if (accessToken.userId !== user.id) return;

    // desensitized email address
    const email = user.email;
    const [prefix, domain] = email.split('@');

    const desensitizedName =
      prefix.length === 1
        ? '*'
        : prefix.length == 2
        ? `${prefix[0]}*`
        : `${prefix[0]}${'*'.repeat(prefix.length - 3)}${
            prefix[prefix.length - 1]
          }`;

    return `${desensitizedName}@${domain}`;
  }

  /**
   * Resolve user entity phone field.
   *
   * Desensitized phone number.
   */
  @ResolveField('phone', () => String, { nullable: true })
  @Auth.nullable()
  resolvePhone(
    @Parent() user: _User,
    @Auth.accessToken() accessToken: AccessToken,
  ): string | null | undefined {
    if (!user.phone) return;
    if (!accessToken) return;
    if (accessToken.userId !== user.id) return;

    // desensitized phone number
    const phone = parsePhoneNumber(user.phone).format('E.164');

    return `${phone.substring(0, 5)}${'*'.repeat(
      phone.length - 7,
    )}${phone.substring(phone.length - 2)}`;
  }
}
