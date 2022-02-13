// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Module } from '@nestjs/common';
import { PrismaModule } from 'src/prisma.module';
import { UserProfileModule } from './profile/user-profile.module';
import { UserResolver } from './user.resolver';
import { UserService } from './user.service';

@Module({
  imports: [PrismaModule, UserProfileModule],
  providers: [UserService, UserResolver],
})
export class UserModule {}
