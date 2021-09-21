import { ClassProvider, Module } from '@nestjs/common';
import { PrismaClient } from '@prisma/client';

const PrismaProvider: ClassProvider<PrismaClient> = {
  provide: PrismaClient,
  useClass: class extends PrismaClient {},
};

@Module({
  providers: [PrismaProvider],
  exports: [PrismaProvider],
})
export class PrismaModule {
  static forRoot() {
    return {
      global: true,
      module: PrismaModule,
    };
  }
}
