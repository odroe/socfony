import { DynamicModule, Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { database } from './database.config';
import { PrismaClientImpl } from './prisma.client';

@Module({
  imports: [ConfigModule.forFeature(database)],
  providers: [PrismaClientImpl.provider],
  exports: [PrismaClientImpl.provider],
})
export class PrismaModule {
  static forRoot(): DynamicModule {
    return {
      module: PrismaModule,
      global: true,
    };
  }
}
