import { Module } from '@nestjs/common';
import { AuthModule } from 'src/auth';
import { PrismaModule } from 'src/prisma.module';
import { COSModule } from './cos';
import { StorageResolver } from './storage.resolver';
import { StorageService } from './storage.service';

@Module({
  imports: [COSModule, AuthModule, PrismaModule],
  providers: [StorageResolver, StorageService],
  exports: [StorageService],
})
export class StorageModule {}
