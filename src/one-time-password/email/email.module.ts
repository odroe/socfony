import { forwardRef, Module } from '@nestjs/common';
import { PrismaModule } from 'src/prisma.module';
import { OneTimePasswordModule } from '../one-time-password.module';
import { EmailService } from './email.service';

@Module({
  imports: [PrismaModule, forwardRef(() => OneTimePasswordModule)],
  providers: [EmailService],
  exports: [EmailService],
})
export class EmailModule {}
