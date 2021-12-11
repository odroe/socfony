// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Module } from '@nestjs/common';
import { MediaResolver } from './media.resolver';
import { MediaService } from './media.service';

@Module({
  providers: [MediaResolver, MediaService],
  exports: [MediaService],
})
export class MediaModule {}
