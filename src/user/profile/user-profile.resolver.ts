// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Args, ID, Query, Resolver } from '@nestjs/graphql';
import { PrismaClient, UserProfile as _UserProfile } from '@prisma/client';
import { UserProfile } from './entities/user-profile.entity';
import { UserProfileService } from './user-profile.service';

@Resolver(() => UserProfile)
export class UserProfileResolver {
  constructor(
    private readonly userProfileService: UserProfileService,
    private readonly prisma: PrismaClient,
  ) {}

  @Query(() => UserProfile, {
    nullable: true,
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
}
