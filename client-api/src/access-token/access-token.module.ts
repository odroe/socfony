import { Module } from '@nestjs/common';
import { AccessTokenService } from './access-token.service';
import { AccessTokenResolver } from './access-token.resolver';

@Module({
  providers: [AccessTokenService, AccessTokenResolver]
})
export class AccessTokenModule {}
