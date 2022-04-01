import { Module } from '@nestjs/common';
import { AuthModule } from 'src/auth';
import { PrismaModule } from 'src/prisma.module';
import { StorageResolver } from './storage.resolver';
import { StorageHost } from './storage_host';
import { TencentCloudObjectStorageClient } from './tencent_cloud_object_storage_client';
import { TencentCloudSTSClient } from './tencent_cloud_sts_service';

@Module({
  imports: [AuthModule, PrismaModule],
  providers: [
    StorageResolver,
    StorageHost,
    TencentCloudObjectStorageClient,
    TencentCloudSTSClient,
  ],
  exports: [StorageHost],
})
export class StorageModule {}
