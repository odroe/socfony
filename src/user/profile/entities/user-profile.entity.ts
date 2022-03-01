// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Field, ID, Int, ObjectType, registerEnumType } from '@nestjs/graphql';
import { Prisma, UserGender, User as _User } from '@prisma/client';
import { File } from 'src/storage';
import { User } from 'src/user/entities/user.entity';

registerEnumType(UserGender, {
  name: 'UserGender',
  description: 'User Gender',
});

@ObjectType()
export class UserProfile
  implements
    Omit<
      Prisma.UserProfileGetPayload<{
        include: {
          user: true;
        };
      }>,
      'avatar'
    >
{
  @Field(() => ID, { description: 'User ID' })
  userId: string;

  @Field(() => File, { description: 'User avatar', nullable: true })
  avatar?: File;

  @Field(() => String, { description: 'User bio', nullable: true })
  bio: string | null;

  @Field(() => Int, { description: 'User birthday', nullable: true })
  birthday: number | null;

  @Field(() => UserGender, { description: 'User gender' })
  gender: UserGender;

  @Field(() => User, { description: 'Profile owner' })
  user: _User;
}
