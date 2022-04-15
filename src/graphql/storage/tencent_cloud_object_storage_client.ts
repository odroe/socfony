import { Inject, Injectable } from '@nestjs/common';
import type { ConfigType } from '@nestjs/config';
import Client = require('cos-nodejs-sdk-v5');
import tencentCloudObjectStorageConfigure from 'src/configuration/tencent_cloud_object_storage';

export interface CreateObjectURLOptions {
  expiresIn?: number;
  query?: Record<string, any>;
  headers?: Record<string, any>;
  method?: Client.Method;
}

@Injectable()
export class TencentCloudObjectStorageClient extends Client {
  constructor(
    @Inject(tencentCloudObjectStorageConfigure.KEY)
    private readonly configure: ConfigType<
      typeof tencentCloudObjectStorageConfigure
    >,
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

  /**
   * Create a signed URL for the given bucket and key.
   * @param location Object location
   * @param options Create URL options
   * @returns {string}
   */
  createObjectURL(
    location: string,
    options?: CreateObjectURLOptions,
  ): Promise<string> {
    return new Promise((resolve, reject) => {
      this.getObjectUrl(
        {
          Bucket: this.bucket,
          Region: this.region,
          Key: location,
          Expires: options?.expiresIn,
          Query: options?.query,
          Headers: options?.headers,
          Method: options?.method,
          Sign: true,
        },
        (error, result) => {
          if (error) return reject(error);

          resolve(result.Url);
        },
      );
    });
  }
}
