// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { ArgsType, Field, Int } from '@nestjs/graphql';

@ArgsType()
export class PaginationArgs {
  @Field(() => Int, { defaultValue: 15, nullable: true })
  take!: number;

  @Field(() => Int, { defaultValue: 0, nullable: true })
  skip!: number;
}
