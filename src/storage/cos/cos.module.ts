import { Module } from '@nestjs/common';
import { PrismaModule } from 'src/prisma.module';
import { COSService } from './cos.service';

@Module({
  imports: [PrismaModule],
  providers: [COSService],
  exports: [COSService],
})
export class COSModule {}
