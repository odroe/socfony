import {  Global, Module } from '@nestjs/common';
import { PrismaClientImpl } from './prisma.client';

@Global()
@Module({
  providers: [PrismaClientImpl.provider],
  exports: [PrismaClientImpl.provider],
})
export class PrismaModule {}
