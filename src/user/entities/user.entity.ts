// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Field, ID, ObjectType } from '@nestjs/graphql';
import { User as $ } from '@prisma/client';
import { DateTime } from 'graphql/scalars/date_time.scalar';
import { UserProfile } from 'user/profile/entities/user_profile.entity';

@ObjectType()
export class User implements $ {
  @Field(() => ID)
  id!: string;

  @Field(() => String, { nullable: true })
  name!: string | null;

  @Field(() => String, { nullable: true })
  phone!: string | null;

  @Field(() => DateTime)
  createdAt!: Date;

  @Field(() => UserProfile)
  profile!: UserProfile;
}
