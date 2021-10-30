import { Module } from '@nestjs/common';
import { AccessTokenService } from './access-token.service';

@Module({
  providers: [AccessTokenService],
  exports: [AccessTokenService],
})
export class AccessTokenModule {}
