import { Module } from '@nestjs/common';
import { OTPCommonModule } from '../common';
import { SMSService } from './sms.service';

@Module({
  imports: [OTPCommonModule],
  providers: [SMSService],
  exports: [SMSService],
})
export class SMSModule {}
