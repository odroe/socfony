// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import {
  FactoryProvider,
  Inject,
  Injectable,
  Module,
  OnModuleDestroy,
  OnModuleInit,
} from '@nestjs/common';
import { ConfigType } from '@nestjs/config';
import { PrismaClient } from '@prisma/client';
import database from './configuration/database';

@Injectable()
class PrismaClientImpl implements OnModuleInit, OnModuleDestroy {
  public readonly prisma: PrismaClient;

  constructor(@Inject(database.KEY) { url }: ConfigType<typeof database>) {
    this.prisma = new PrismaClient({
      datasources: {
        db: { url },
      },
    });
  }

  async onModuleInit() {
    await this.prisma.$connect();
  }

  async onModuleDestroy() {
    await this.prisma.$disconnect();
  }
}

const provider: FactoryProvider<PrismaClient> = {
  provide: PrismaClient,
  inject: [PrismaClientImpl],
  useFactory: ({ prisma }: PrismaClientImpl) => prisma,
};

@Module({
  providers: [PrismaClientImpl, provider],
  exports: [provider],
})
export class PrismaModule {}
