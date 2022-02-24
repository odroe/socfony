import { Module } from '@nestjs/common';
import { AuthModule } from 'src/auth';
import { PrismaModule } from 'src/prisma.module';
import { OneTimePasswordResolver } from './one-time-password.resolver';
import { OneTimePasswordService } from './one-time-password.service';
import { SMSModule } from './sms';

@Module({
  imports: [AuthModule, PrismaModule, SMSModule],
  providers: [OneTimePasswordResolver, OneTimePasswordService],
  exports: [OneTimePasswordService],
})
export class OneTimePasswordModule {}
