import { Module } from '@nestjs/common';
import { COSModule } from './cos';
import { StorageResolver } from './storage.resolver';
import { StorageService } from './storage.service';

@Module({
  imports: [COSModule],
  providers: [StorageResolver, StorageService],
  exports: [StorageService],
})
export class StorageModule {}
