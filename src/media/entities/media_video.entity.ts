// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Field, ObjectType } from '@nestjs/graphql';
import { Media } from './media.entity';

/**
 * Media Video Entity
 */
@ObjectType({
  description: 'Media Video Entity',
})
export class MediaVideo {
  /**
   * Video src.
   */
  @Field(() => Media, { description: 'Video media' })
  video!: Media;

  /**
   * Video poster.
   */
  @Field(() => String, { description: 'Video poster' })
  poster!: Media;
}
