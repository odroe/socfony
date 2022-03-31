import { Module } from '@nestjs/common';
import { AuthModule } from 'src/auth';
import { PrismaModule } from 'src/prisma.module';
import { COSModule } from './cos';
import { StorageResolver } from './storage.resolver';
import { StorageService } from './storage.service';
import { StorageHost } from './storage_host';
import { TencentCloudObjectStorageClient } from './tencent_cloud_object_storage_client';

@Module({
  imports: [COSModule, AuthModule, PrismaModule],
  providers: [StorageResolver, StorageService, TencentCloudObjectStorageClient, StorageHost],
  exports: [StorageService],
})
export class StorageModule {}
