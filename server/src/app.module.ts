import { Module } from '@nestjs/common';
import { VerificationCodeModule } from './verification-code/verification-code.module';

@Module({
  imports: [VerificationCodeModule],
})
export class AppModule {}
