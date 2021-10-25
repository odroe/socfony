import { Global, Module } from '@nestjs/common';
import { PrismaModule } from './prisma';

@Global()
@Module({
  imports: [PrismaModule],
  exports: [PrismaModule],
})
export class GlobalModule {}
