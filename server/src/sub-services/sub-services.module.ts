import { Module } from '@nestjs/common';
import { AccessTokenSubServiceModule } from './access-token';
import { VerificationCodeSubServiceModule } from './verification-code';

@Module({
  imports: [AccessTokenSubServiceModule, VerificationCodeSubServiceModule],
})
export class SubServicesModule {}
