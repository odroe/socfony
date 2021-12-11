// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { AccessToken as $AccessToken } from '@prisma/client';
import { Field, ID, ObjectType } from '@nestjs/graphql';
import { DateTime } from 'graphql/scalars/date_time.scalar';
import { User } from 'user/entities/user.entity';

@ObjectType()
export class AccessToken implements $AccessToken {
  @Field(() => ID)
  userId!: string;

  @Field(() => DateTime)
  createdAt!: Date;

  @Field(() => DateTime)
  expiredAt!: Date;

  @Field(() => DateTime)
  refreshExpiredAt!: Date;

  @Field(() => String)
  token!: string;

  @Field(() => User)
  user!: User;
}
