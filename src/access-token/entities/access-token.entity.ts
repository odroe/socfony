// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Field, GraphQLISODateTime, ID, ObjectType } from '@nestjs/graphql';
import { AccessToken as AccessTokenInterface } from '@prisma/client';

@ObjectType()
export class AccessToken implements AccessTokenInterface {
  @Field(() => String, { description: 'Access token' })
  token: string;

  @Field(() => ID, { description: 'The token owner User ID' })
  userId: string;

  @Field(() => GraphQLISODateTime, { description: 'Token expired at' })
  expiredAt: Date;

  @Field(() => GraphQLISODateTime, { description: 'Token created at' })
  createdAt: Date;

  @Field(() => GraphQLISODateTime, { description: 'Token refresh expired at' })
  refreshExpiredAt: Date;
}
