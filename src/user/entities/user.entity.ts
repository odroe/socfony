// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Field, ID, ObjectType } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';

@ObjectType()
export class User
  implements
    Omit<
      Prisma.UserGetPayload<{
        include: {
          accessTokens: false;
        };
      }>,
      'password'
    >
{
  @Field(() => ID, { description: 'User ID' })
  id: string;

  @Field(() => String, { description: 'User unique name' })
  username: string;

  @Field(() => String, { description: 'User email' })
  email: string;

  @Field(() => String, { description: 'User phone' })
  phone: string;
}
