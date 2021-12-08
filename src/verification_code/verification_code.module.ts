import { Module } from '@nestjs/common';
import { VerificationCodeResolver } from './verification_code.resolver';
import { VerificationCodeService } from './verification_code.service';

@Module({
  providers: [VerificationCodeResolver, VerificationCodeService],
  exports: [VerificationCodeService],
})
export class VerificationCodeModule {}
