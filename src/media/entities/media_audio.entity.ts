// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Field, ObjectType } from '@nestjs/graphql';
import { Media } from './media.entity';

@ObjectType()
export class MediaAudio {
  @Field(() => Media, { description: `Audio poster`, nullable: true })
  poster?: Media;

  @Field(() => Media, { description: `Audio file` })
  audio!: Media;
}
