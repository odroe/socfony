import Client = require('cos-nodejs-sdk-v5');
import { Inject, Injectable } from '@nestjs/common';
import { ConfigType } from '@nestjs/config';
import { tencentcloud } from 'src/configuration';
import { PrismaClient } from '@prisma/client';
import { ERROR_CODE_STORAGE_NOT_FOUND } from 'src/errorcodes';
import { CreateStorageUrlOptions } from './interfaces';

@Injectable()
export class StorageService extends Client {
  constructor(
    @Inject(tencentcloud.cos.KEY)
    private readonly configure: ConfigType<typeof tencentcloud.cos>,
    private readonly prisma: PrismaClient,
  ) {
    super({
      SecretId: configure.secretId,
      SecretKey: configure.secretKey,
      Protocol: configure.protocol,
      Domain: configure.domain,
    });
  }

  /**
   * Create a signed URL by location.
   */
  createObjectURLBylocation(
    location: string,
    options?: CreateStorageUrlOptions,
  ): Promise<string> {
    return new Promise((resolve, reject) => {
      this.getObjectUrl(
        {
          Bucket: this.configure.bucket!,
          Region: this.configure.region!,
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

  /**
   * Create a signed URL by storage id.
   */
  async createObjectURLByStorageId(
    storageId: string,
    options?: CreateStorageUrlOptions,
  ): Promise<string> {
    const { location } = await this.prisma.storage.findUnique({
      where: { id: storageId },
      select: { location: true },
      rejectOnNotFound: () => new Error(ERROR_CODE_STORAGE_NOT_FOUND),
    });

    return this.createObjectURLBylocation(location, options);
  }
}
