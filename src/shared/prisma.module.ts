// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import {
  ClassProvider,
  Module,
  OnModuleDestroy,
  OnModuleInit,
} from '@nestjs/common';
import { PrismaClient } from '@prisma/client';

const _privider: ClassProvider<PrismaClient> = {
  provide: PrismaClient,
  useClass: class extends PrismaClient implements OnModuleInit, OnModuleDestroy {
    async onModuleInit() {
      await this.$connect();
    }

    async onModuleDestroy() {
      await this.$disconnect();
    }
  },
};

@Module({
  providers: [_privider],
  exports: [_privider],
})
export class PrismaModule {}
