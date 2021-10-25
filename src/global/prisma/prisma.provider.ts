import { PrismaClient } from '@prisma/client';
import { ClassProvider, OnModuleDestroy, OnModuleInit } from '@nestjs/common';

export const PrismaProvider: ClassProvider<PrismaClient> = {
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
