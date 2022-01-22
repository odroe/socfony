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

const PrismaClassProvider: ClassProvider<PrismaClient> = {
  provide: PrismaClient,
  useClass: class extends PrismaClient implements OnModuleInit, OnModuleDestroy {
    async onModuleDestroy() {
      await this.$connect();
    }

    async onModuleInit() {
      await this.$disconnect();
    }
  },
};

@Module({
  providers: [PrismaClassProvider],
  exports: [PrismaClassProvider],
})
export class PrismaModule {}
