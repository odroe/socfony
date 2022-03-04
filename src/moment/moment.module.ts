import { Module } from '@nestjs/common';
import { AuthModule } from 'src/auth';
import { PrismaModule } from 'src/prisma.module';
import { MomentResolver } from './moment.resolver';

@Module({
  imports: [PrismaModule, AuthModule],
  providers: [MomentResolver],
})
export class MomentModule {}
