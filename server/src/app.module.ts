import { Module } from '@nestjs/common';
import { AccessTokenModule } from './access-token/access-token.module';
import { VerificationCodeModule } from './verification-code/verification-code.module';

@Module({
  imports: [AccessTokenModule, VerificationCodeModule],
})
export class AppModule {}
