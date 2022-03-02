import { Module } from '@nestjs/common';
import { PrismaModule } from 'src/prisma.module';
import { OTPCommonModule } from '../common';
import { SMSService } from './sms.service';

@Module({
  imports: [PrismaModule, OTPCommonModule],
  providers: [SMSService],
  exports: [SMSService],
})
export class SMSModule {}
