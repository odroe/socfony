import { ClassProvider, Global, Module } from '@nestjs/common';
import { PrismaClient } from '@prisma/client';

const PrismaProvider: ClassProvider<PrismaClient> = {
  provide: PrismaClient,
  useClass: class extends PrismaClient {},
};

@Global()
@Module({
  providers: [PrismaProvider],
  exports: [PrismaProvider],
})
export class PrismaModule {}
