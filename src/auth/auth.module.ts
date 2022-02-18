// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Module } from '@nestjs/common';
import { PrismaModule } from 'src/prisma.module';
import { AuthNullableGuard } from './auth-nullable.guard';
import { AuthRefreshGuard } from './auth-refresh.guard';
import { AuthGuard } from './auth.guard';

@Module({
  imports: [PrismaModule],
  providers: [AuthNullableGuard, AuthGuard, AuthRefreshGuard],
})
export class AuthModule {}
