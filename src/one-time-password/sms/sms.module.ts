import { forwardRef, Module } from '@nestjs/common';
import { PrismaModule } from 'src/prisma.module';
import { OneTimePasswordModule } from '../one-time-password.module';
import { SMSService } from './sms.service';

@Module({
  imports: [PrismaModule, forwardRef(() => OneTimePasswordModule)],
  providers: [SMSService],
  exports: [SMSService],
})
export class SMSModule {}
