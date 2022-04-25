// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Module } from '@nestjs/common';
import { AuthModule } from 'src/auth';
import { StorageModule } from 'old/storage';
import { UserProfileResolver } from './user-profile.resolver';
import { UserProfileService } from './user-profile.service';

@Module({
  imports: [AuthModule, StorageModule],
  providers: [UserProfileService, UserProfileResolver],
  exports: [UserProfileService],
})
export class UserProfileModule {}
