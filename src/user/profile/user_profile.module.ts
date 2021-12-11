// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Module } from '@nestjs/common';
import { MediaModule } from 'media/media.module';
import { UserProfileResolver } from './user_profile.resolver';
import { UserProfileService } from './user_profile.service';

@Module({
  imports: [MediaModule],
  providers: [UserProfileService, UserProfileResolver],
  exports: [UserProfileService],
})
export class UserProfileModule {}
