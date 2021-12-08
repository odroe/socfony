import { Module } from '@nestjs/common';
import { VerificationCodeResolver } from './verification-code.resolver';

@Module({
  providers: [VerificationCodeResolver],
})
export class VerificationCodeModule {}
