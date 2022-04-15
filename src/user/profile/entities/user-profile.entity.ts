// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Field, ID, Int, ObjectType, registerEnumType } from '@nestjs/graphql';
import {  UserGender, UserProfile as UserProfileInterface } from '@prisma/client';

registerEnumType(UserGender, {
  name: 'UserGender',
  description: 'User Gender',
});

@ObjectType()
export class UserProfile
  implements UserProfileInterface
{
  @Field(() => ID, { description: 'User ID' })
  userId: string;

  @Field(() => String, {
    description: 'User avatar storage ID',
    nullable: true,
  })
  avatarStorageId: string | null;

  @Field(() => String, { description: 'User bio', nullable: true })
  bio: string | null;

  @Field(() => Int, { description: 'User birthday', nullable: true })
  birthday: number | null;

  @Field(() => UserGender, { description: 'User gender' })
  gender: UserGender;
}
