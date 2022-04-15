import { Module } from '@nestjs/common';
import { PrismaModule } from 'src/prisma.module';
import { OTPCommonModule } from './common';
import { EmailModule } from './email';
import { OneTimePasswordResolver } from './one-time-password.resolver';
import { OneTimePasswordService } from './one-time-password.service';
import { SMSModule } from './sms';

@Module({
  imports: [OTPCommonModule, SMSModule, EmailModule, PrismaModule],
  providers: [OneTimePasswordResolver, OneTimePasswordService],
  exports: [OneTimePasswordService],
})
export class OneTimePasswordModule {}
