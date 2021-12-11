// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Global, Module } from '@nestjs/common';
import { AuthModule } from './auth/auth.module';
import { PrismaModule } from './prisma.module';

const modules = [PrismaModule, AuthModule];

@Global()
@Module({
  imports: modules,
  exports: modules,
})
export class SharedModule {}
