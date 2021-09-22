import { Module } from '@nestjs/common';
import { AccessTokenService } from './access-token.service';
import { AccessTokenResolver } from './access-token.resolver';
import { StorageBoxModule } from 'src/storage-box';
import { VerificationCodeModule } from 'src/verification-code/verification-code.module';

@Module({
  imports: [StorageBoxModule.box('auth'), VerificationCodeModule],
  providers: [AccessTokenService, AccessTokenResolver],
})
export class AccessTokenModule {}
