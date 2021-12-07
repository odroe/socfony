import { forwardRef, Module } from '@nestjs/common';
import { AccessTokenModule } from 'src/access-token/access-token.module';
import { PrismaModule, TencentcloudSmsModule } from 'src/shared';
import { VerificationCodeMutation } from './verification-code.mutation';
import { VerificationCodeService } from './verification-code.service';

@Module({
  imports: [
    PrismaModule,
    TencentcloudSmsModule,
    forwardRef(() => AccessTokenModule),
  ],
  controllers: [VerificationCodeMutation],
  providers: [VerificationCodeService],
  exports: [VerificationCodeService],
})
export class VerificationCodeModule {}
