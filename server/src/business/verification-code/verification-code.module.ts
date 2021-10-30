import { Module } from '@nestjs/common';
import { TencentcloudSmsModule } from 'src/shared';
import { VerificationCodeService } from './verification-code.service';

@Module({
  imports: [TencentcloudSmsModule],
  providers: [VerificationCodeService],
  exports: [VerificationCodeService],
})
export class VerificationCodeModule {}
