import { Module } from '@nestjs/common';
import { PrismaModule } from '../prisma';
import { TencentcloudSmsService } from './tencentcloud-sms.service';

@Module({
  imports: [PrismaModule],
  providers: [TencentcloudSmsService],
  exports: [TencentcloudSmsService],
})
export class TencentcloudSmsModule {}
