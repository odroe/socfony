import { Module } from '@nestjs/common';
import { PrismaModule } from 'src/prisma.module';
import { MomentResolver } from './moment.resolver';

@Module({
  imports: [PrismaModule],
  providers: [MomentResolver],
})
export class MomentModule {}
