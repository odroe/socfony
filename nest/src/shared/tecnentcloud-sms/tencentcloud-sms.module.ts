import { Module } from '@nestjs/common';
import { TencentcloudSmsService } from './tencentcloud-sms.service';

@Module({
  providers: [TencentcloudSmsService],
  exports: [TencentcloudSmsService],
})
export class TencentcloudSmsModule {}
