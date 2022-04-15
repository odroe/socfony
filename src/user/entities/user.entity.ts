// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Field, ID, ObjectType } from '@nestjs/graphql';
import {
  User as UserInterface,
} from '@prisma/client';

@ObjectType()
export class User
  implements
    Pick<UserInterface, 'id' | 'username'>
{
  @Field(() => ID, { description: 'User ID' })
  id: string;

  @Field(() => String, { description: 'User unique name', nullable: true })
  username: string;
}
