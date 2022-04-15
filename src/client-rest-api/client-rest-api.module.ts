import { Module } from '@nestjs/common';
import { AuthModule } from 'src/shared/auth';
import { PrismaModule } from 'src/shared';
import { MomentModule } from './moment';

@Module({
  imports: [PrismaModule.forRoot(), AuthModule.forRoot(), MomentModule],
})
export class ClientRestApiModule {}
