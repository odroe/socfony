import { Module } from '@nestjs/common';
import { PrismaModule } from 'src/prisma.module';
import { OTPCommonService } from './otp-common.service';

@Module({
  imports: [PrismaModule],
  providers: [OTPCommonService],
  exports: [OTPCommonService],
})
export class OTPCommonModule {}
