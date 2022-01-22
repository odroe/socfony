import { Module } from '@nestjs/common';
import { PrismaModule } from 'src/prisma.module';
import { AccessTokenResolver } from './access-token.resolver';
import { AccessTokenService } from './access-token.service';

@Module({
  imports: [PrismaModule],
  providers: [AccessTokenService, AccessTokenResolver],
})
export class AccessTokenModule {}
