import { Module } from '@nestjs/common';
import { OTPCommonService } from './otp-common.service';

@Module({
  providers: [OTPCommonService],
  exports: [OTPCommonService],
})
export class OTPCommonModule {}
