import { Module } from '@nestjs/common';
import { AccessTokenService } from './access-token.service';
import { AccessTokenResolver } from './access-token.resolver';
import { StorageBoxModule } from 'src/storage-box';

@Module({
  imports: [StorageBoxModule.box('auth')],
  providers: [AccessTokenService, AccessTokenResolver],
})
export class AccessTokenModule {}
