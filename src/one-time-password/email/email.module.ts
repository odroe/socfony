import { Module } from '@nestjs/common';
import { OTPCommonModule } from '../common';
import { EmailService } from './email.service';

@Module({
  imports: [OTPCommonModule],
  providers: [EmailService],
  exports: [EmailService],
})
export class EmailModule {}
