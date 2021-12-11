// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { ArgsType, Field } from '@nestjs/graphql';

@ArgsType()
export class UserUpdatePhoneArgs {
  @Field(() => String)
  phone!: string;

  @Field(() => String)
  otp!: string;

  @Field(() => String, { nullable: true })
  currentOtp?: string;
}
