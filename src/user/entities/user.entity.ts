// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Field, ID, ObjectType } from '@nestjs/graphql';
import {
  Prisma,
  UserProfile as _UserProfile,
  Moment as _Moment,
  Comment as _Comment,
} from '@prisma/client';
import { Comment } from 'src/comment/entities/comment.entity';
import { Moment } from 'src/moment/entities/moment.entity';
import { UserProfile } from '../profile/entities/user-profile.entity';

@ObjectType()
export class User
  implements
    Omit<
      Prisma.UserGetPayload<{
        include: {
          accessTokens: false;
          profile: true;
          moments: true;
          comments: true;
        };
      }>,
      'password' | 'email' | 'phone'
    >
{
  @Field(() => ID, { description: 'User ID' })
  id: string;

  @Field(() => String, { description: 'User unique name', nullable: true })
  username: string;

  @Field(() => UserProfile)
  profile: _UserProfile;

  @Field(() => [Moment], { nullable: 'items' })
  moments: _Moment[];

  @Field(() => [Moment], { nullable: 'items' })
  likedMoments: _Moment[];

  @Field(() => [Comment], { nullable: 'items' })
  comments: _Comment[];
}
