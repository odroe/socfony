import { Module } from '@nestjs/common';
import { AuthModule } from 'src/shared/auth';
import { PrismaModule } from 'src/prisma.module';
import { StorageResolver } from './storage.resolver';
import { StorageService } from './storage.service';
import { TencentCloudObjectStorageClient } from './tencent_cloud_object_storage_client';

@Module({
  imports: [AuthModule, PrismaModule],
  providers: [TencentCloudObjectStorageClient, StorageService, StorageResolver],
  exports: [TencentCloudObjectStorageClient, StorageService],
})
export class StorageModule {}
