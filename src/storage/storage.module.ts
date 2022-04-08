import { Module } from '@nestjs/common';
import { AuthModule } from 'src/auth';
import { PrismaModule } from 'src/prisma.module';
import { StorageResolver } from './storage.resolver';
import { TencentCloudObjectStorageClient } from './tencent_cloud_object_storage_client';

@Module({
  imports: [AuthModule, PrismaModule],
  providers: [TencentCloudObjectStorageClient, StorageResolver],
  exports: [TencentCloudObjectStorageClient],
})
export class StorageModule {}
