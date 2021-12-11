// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Field, InputType, PartialType, PickType } from '@nestjs/graphql';
import { UserProfile_gender } from '@prisma/client';
import { UserProfile } from '../entities/user_profile.entity';

/**
 * Update user profile input.
 */
@InputType({
  description: 'Update user profile input.',
})
export class UpdateUserProfileInput extends PartialType(
  PickType(UserProfile, ['bio', 'birthday', 'gender', 'name'] as const),
  InputType,
) {
  /**
   * The user gender, value is UserProfile_gender
   */
  @Field(() => UserProfile_gender, {
    nullable: true,
    description: 'The user gender, value is woman/man/unknown',
  })
  declare gender?: UserProfile_gender;
}
