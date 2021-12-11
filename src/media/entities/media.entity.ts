// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Field, ObjectType } from '@nestjs/graphql';

@ObjectType()
export class Media {
  constructor(key: string) {
    this.key = key;
  }

  @Field(() => String)
  key: string;

  @Field(() => String)
  url!: string;

  toString(): string {
    return this.key;
  }
}
