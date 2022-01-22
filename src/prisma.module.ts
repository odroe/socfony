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
