import { Injectable, OnModuleDestroy, OnModuleInit } from "@nestjs/common";
import fs, { FilesystemAdapter, ProtocolPath } from "@odroe/fs";
import { COSAdapter } from "@odroe/fs-cos";
import { TencentCloudObjectStorageClient } from "./tencent_cloud_object_storage_client";

@Injectable()
export class StorageHost implements OnModuleInit, OnModuleDestroy {
  public readonly protocol: 'cloud' = 'cloud';
  private readonly adapter: FilesystemAdapter;

  constructor(
    client: TencentCloudObjectStorageClient
  ) {
    this.adapter = COSAdapter.forClient(client, client.bucket, client.region);
  }

  onModuleDestroy() {
    fs.unregisterAdapter(this.protocol);
  }

  onModuleInit() {
    fs.registerAdapter(this.protocol, this.adapter);
  }

  path(path: string) {
    return ProtocolPath.protocol(this.protocol).setPath(path);
  }
}
