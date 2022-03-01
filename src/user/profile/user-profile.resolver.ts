// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import {
  Args,
  ID,
  Mutation,
  Parent,
  Query,
  ResolveField,
  Resolver,
} from '@nestjs/graphql';
import {
  AccessToken,
  PrismaClient,
  User as _User,
  UserProfile as _UserProfile,
} from '@prisma/client';
import { Auth } from 'src/auth';
import { File } from 'src/storage';
import { User } from '../entities/user.entity';
import { UserProfileUncheckedUpdateInput } from './dto/user-profile-unckecked-update.input';
import { UserProfile } from './entities/user-profile.entity';
import { UserProfileService } from './user-profile.service';

@Resolver(() => UserProfile)
export class UserProfileResolver {
  constructor(
    private readonly userProfileService: UserProfileService,
    private readonly prisma: PrismaClient,
  ) {}

  /**
   * Find user profile by user ID.
   * @param id User ID.
   * @returns UserProfile
   */
  @Query(() => UserProfile, {
    description: 'Find User profile',
  })
  async userProfile(
    @Args({ name: 'id', type: () => ID, description: 'User ID' }) id: string,
  ): Promise<_UserProfile> {
    const user = await this.prisma.user.findUnique({
      where: { id },
      rejectOnNotFound: () => new Error('User not found'),
    });

    return this.userProfileService.resolve(user);
  }

  /**
   * Update current user profile.
   * @param data Update user profile data.
   * @param param1 @author.accessToken()
   * @returns UserProfile
   */
  @Auth.must()
  @Mutation(() => UserProfile)
  async updateUserProfile(
    @Args({
      name: 'data',
      type: () => UserProfileUncheckedUpdateInput,
      description: 'User profile data',
    })
    data: UserProfileUncheckedUpdateInput,
    @Auth.accessToken() { userId }: AccessToken,
  ): Promise<_UserProfile> {
    // Resolve user profile.
    const profile = await this.userProfileService.resolve(userId);

    // Update user profile.
    return this.prisma.userProfile.update({
      where: { userId: profile.userId },
      data,
    });
  }

  /**
   * Resolve user profile user field.
   * @param profile @Parent()
   * @returns User
   */
  @ResolveField(() => User)
  async user(@Parent() profile: UserProfile): Promise<_User> {
    if (!profile.user) {
      return this.prisma.user.findUnique({
        where: { id: profile.userId },
        rejectOnNotFound: () => new Error('User not found'),
      });
    }

    return profile.user;
  }

  /**
   * Resolve user profile avatar field.
   * @param profile @Parent()
   * @returns {File | null}
   */
  @ResolveField(() => File, { nullable: true })
  avatar(@Parent() { avatar }: _UserProfile): File | null {
    if (avatar) return File.fromPath(avatar);

    return null;
  }
}
