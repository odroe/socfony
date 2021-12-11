// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { ArgsType, Field, PickType } from '@nestjs/graphql';
import { MultiMediaInput } from 'media/dto/multi_media.input';
import { Moment } from 'moment/entities/moment.entity';

/**
 * Create a new moment input.
 */
@ArgsType()
export class CreateMomentArgs extends PickType(
  Moment,
  ['body', 'title'] as const,
  ArgsType,
) {
  @Field(() => [MultiMediaInput], { nullable: 'itemsAndList' })
  media?: MultiMediaInput[];
}
