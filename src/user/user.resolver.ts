// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import {
  Args,
  Mutation,
  Parent,
  Query,
  ResolveField,
  Resolver,
} from '@nestjs/graphql';
import { AccessToken, OneTimePasswordType, PrismaClient } from '@prisma/client';
import { Auth } from 'src/auth';
import { OneTimePasswordService } from 'src/one-time-password';
import { UpdateUserPhoneArgs } from './dto/update-user-phone.args';
import { UserFindManyArgs } from './dto/user-find-many.args';
import { UserWhereUniqueInput } from './dto/user-where-unique.input';
import { User } from './entities/user.entity';
import { UserProfile } from './profile/entities/user-profile.entity';
import { UserProfileService } from './profile/user-profile.service';
import { UserService } from './user.service';

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
   * Update current user phone.
   * @param args Update user phone args.
   * @param { userId } @Auth.accessToken()
   */
  @Mutation(() => User)
  @Auth.must()
  async updateUserPhone(
    @Args({ type: () => UpdateUserPhoneArgs }) args: UpdateUserPhoneArgs,
    @Auth.accessToken() { userId }: AccessToken,
  ) {
    // Find current user.
    const user = await this.prisma.user.findUnique({
      where: { id: userId },
    });

    // If current user phone is args.phone, then return.
    if (user!.phone === args.phone) return user;

    // If user.phone not equal args.phone, check new phone user is exist.
    const newPhoneUser = await this.prisma.user.findUnique({
      where: { phone: args.phone },
      rejectOnNotFound: false,
    });
    if (newPhoneUser && newPhoneUser.id !== user!.id) {
      throw new Error('Phone is already in use.');
    }

    // Create new phone OTP check and delete callback.
    const onBindOtpDelete = await this.otpService.verify(
      OneTimePasswordType.SMS,
      args.phone,
      args.otp,
    );

    // If user bind phone, create old phone OTP check and delete callback.
    let onUnbindOtpDelete: () => Promise<any> = () => Promise.resolve();
    if (user!.phone) {
      // Check old phone OTP.
      if (!args.oldPhoneOTP) {
        throw new Error('Please enter old phone OTP.');
      }

      onUnbindOtpDelete = await this.otpService.verify(
        OneTimePasswordType.SMS,
        user!.phone,
        args.oldPhoneOTP,
      );
    }

    // Update user phone.
    const promise = this.prisma.user.update({
      where: { id: userId },
      data: { phone: args.phone },
    });

    // Delete OTP.
    await Promise.all([onBindOtpDelete(), onUnbindOtpDelete()]);

    return promise;
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
}
