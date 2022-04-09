import { Injectable } from '@nestjs/common';
import { PrismaClient } from '@prisma/client';
import { TencentCloudObjectStorageClient } from './tencent_cloud_object_storage_client';

@Injectable()
export class StorageService {
  constructor(
    private readonly prisma: PrismaClient,
    private readonly cos: TencentCloudObjectStorageClient,
  ) {}

  async delete(id?: string | null): Promise<void> {
    if (!id) return;
    const storage = await this.prisma.storage.findUnique({
      where: { id },
      rejectOnNotFound: false,
    });
    if (!storage) return;

    // Delete from Tencent Cloud Object Storage
    this.cos.deleteObject({
      Bucket: this.cos.bucket,
      Region: this.cos.region,
      Key: storage.location,
    });

    // Delete from Prisma
    await this.prisma.storage.deleteMany({ where: { id } });
  }
}
