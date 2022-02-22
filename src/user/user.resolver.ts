// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Args, Query, Resolver } from '@nestjs/graphql';
import { PrismaClient } from '@prisma/client';
import { UserFindManyArgs } from './dto/user-find-many.args';
import { UserWhereUniqueInput } from './dto/user-where-unique.input';
import { User } from './entities/user.entity';
import { UserService } from './user.service';

@Resolver(() => User)
export class UserResolver {
  constructor(
    private readonly userService: UserService,
    private readonly prisma: PrismaClient,
  ) {}

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

  @Query(() => [User], {
    nullable: 'items',
    description: 'Find users',
  })
  async users(@Args({ type: () => UserFindManyArgs }) args: UserFindManyArgs) {
    return this.prisma.user.findMany(args);
  }
}
