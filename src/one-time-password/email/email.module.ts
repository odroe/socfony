import { Module } from '@nestjs/common';
import { PrismaModule } from 'src/prisma.module';
import { OTPCommonModule } from '../common';
import { EmailService } from './email.service';

@Module({
  imports: [PrismaModule, OTPCommonModule],
  providers: [EmailService],
  exports: [EmailService],
})
export class EmailModule {}
