// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Field, ID, ObjectType } from '@nestjs/graphql';
import { Moment as $Moment, Prisma } from '@prisma/client';
import { Comment } from 'comment/entities/comment.entity';
import { DateTime } from 'graphql/scalars/date_time.scalar';
import { MultiMediaUnion } from 'media/unions/multi_media.union';
import { User } from 'user/entities/user.entity';

/**
 * Moment entity.
 */
@ObjectType({
  description: 'Moment entity',
})
export class Moment implements $Moment {
  /**
   * Moment id.
   */
  @Field(() => ID, { description: 'Moment id' })
  id!: string;

  /**
   * Moment owner id.
   */
  @Field(() => ID, { description: 'User id' })
  userId!: string;

  /**
   * Moment title.
   */
  @Field(() => String, { description: 'Moment title', nullable: true })
  declare title: string | null;

  /**
   * Moment body.
   */
  @Field(() => String, { description: 'Moment body', nullable: true })
  declare body: string | null;

  /**
   * Moment media.
   */
  @Field(() => [MultiMediaUnion], {
    description: 'Moment image',
    nullable: 'itemsAndList',
  })
  declare media: Prisma.JsonValue;

  /**
   * Moment created at.
   */
  @Field(() => DateTime, { description: 'Moment created at' })
  createdAt!: Date;

  /**
   * Moment owner.
   */
  @Field(() => User, { description: 'Moment owner' })
  user!: User;

  @Field(() => [Comment], { description: 'Moment comments' })
  comments!: Comment[];
}
