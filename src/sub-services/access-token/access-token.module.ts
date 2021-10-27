import { Module } from '@nestjs/common';
import { AccessTokenModule, VerificationCodeModule } from 'src/business';
import { AccessTokenSubServiceController } from './access-token.controller';

@Module({
  imports: [AccessTokenModule, VerificationCodeModule],
  controllers: [AccessTokenSubServiceController],
})
export class AccessTokenSubServiceModule {}
