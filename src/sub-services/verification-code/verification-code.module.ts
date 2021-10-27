import { Module } from '@nestjs/common';
import { VerificationCodeSubServiceController } from './verification-code.controller';
import { AccessTokenModule, VerificationCodeModule } from '../../business';

@Module({
  imports: [VerificationCodeModule, AccessTokenModule],
  controllers: [VerificationCodeSubServiceController],
})
export class VerificationCodeSubServiceModule {}
