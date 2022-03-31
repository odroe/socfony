import { Inject, Injectable } from "@nestjs/common";
import type { ConfigType } from "@nestjs/config";
import Client = require("cos-nodejs-sdk-v5");
import tencentCloudObjectStorageConfigure from 'src/configuration/tencent_cloud_object_storage';

@Injectable()
export class TencentCloudObjectStorageClient extends Client {
  constructor(
    @Inject(tencentCloudObjectStorageConfigure.KEY) private readonly configure: ConfigType<typeof tencentCloudObjectStorageConfigure>
  ) {
    super({
      SecretId: configure.secretId,
      SecretKey: configure.secretKey,
      Protocol: configure.protocol,
      Domain: configure.domain,
    });
  }

  get bucket(): string {
    return this.configure.bucket!;
  }

  get region(): string {
    return this.configure.region!;
  }
}