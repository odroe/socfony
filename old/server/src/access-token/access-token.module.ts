import { Module } from '@nestjs/common';
import { PrismaModule } from 'src/shared';
import { VerificationCodeModule } from 'src/verification-code/verification-code.module';
import { AccessTokenMutation } from './access-token.mutation';
import { AccessTokenService } from './access-token.service';

@Module({
  imports: [PrismaModule, VerificationCodeModule],
  controllers: [AccessTokenMutation],
  providers: [AccessTokenService],
  exports: [AccessTokenService],
})
export class AccessTokenModule {}
