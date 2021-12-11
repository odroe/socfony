// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Parent, ResolveField, Resolver } from '@nestjs/graphql';
import { PrismaClient } from '@prisma/client';
import { Comment } from './entities/comment.entity';

@Resolver(() => Comment)
export class CommentResolver {
  constructor(private readonly prisma: PrismaClient) {}

  @ResolveField()
  user(@Parent() { userId }: Comment) {
    return this.prisma.user.findUnique({
      where: { id: userId },
    });
  }
}
