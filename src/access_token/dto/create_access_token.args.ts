// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { ArgsType, Field, PickType } from '@nestjs/graphql';
import { User } from 'user/entities/user.entity';

@ArgsType()
export class CreateAccessTokenArgs extends PickType(
  User,
  ['phone'] as const,
  ArgsType,
) {
  @Field(() => String)
  declare phone: string;

  @Field(() => String)
  otp!: string;
}
