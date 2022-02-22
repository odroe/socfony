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
import { AccessToken, PrismaClient } from '@prisma/client';
import { Auth } from 'src/auth';
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
