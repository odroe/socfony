import { Module } from '@nestjs/common';
import { StorageBoxModule } from 'src/storage-box';
import { SmsClient } from './sms-client';
import { SmsVerificationCodeService } from './sms-verification-code.service';
import { VerificationCodeResolver } from './verification-code.resolver';
import { VerificationCodeService } from './verification-code.service';

@Module({
  imports: [
    StorageBoxModule.box('sms'),
    StorageBoxModule.box('vendor'),
    StorageBoxModule.box('cache'),
  ],
  providers: [
    SmsClient,
    SmsVerificationCodeService,
    VerificationCodeService,
    VerificationCodeResolver,
  ],
})
export class VerificationCodeModule {}
