// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Module } from '@nestjs/common';
import { PrismaModule } from 'src/prisma.module';
import { UserProfileResolver } from './user-profile.resolver';
import { UserProfileService } from './user-profile.service';

@Module({
  imports: [PrismaModule],
  providers: [UserProfileService, UserProfileResolver],
})
export class UserProfileModule {}
