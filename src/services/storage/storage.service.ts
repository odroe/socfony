import Client = require('cos-nodejs-sdk-v5');
import { Inject, Injectable } from '@nestjs/common';
import { ConfigType } from '@nestjs/config';
import { tencentcloud } from 'src/configuration';
import { Prisma, PrismaClient, Storage } from '@prisma/client';
import {
  ERROR_CODE_STORAGE_IS_USED,
  ERROR_CODE_STORAGE_NOT_FOUND,
  ERROR_CODE_STORAGE_NOT_UPLOADED,
  ERROR_CODE_STORAGE_UNKNOWN_MIME_TYPE,
  ERROR_CODE_STORAGE_UNSUPPORTED_MIME_TYPE,
} from 'src/errorcodes';
import { CreateStorageUrlOptions } from './interfaces';
import { SupportedStorageMetadata } from './metadata';
import { ObjectHelper, UtilHelpers } from 'src/helpers';
import { finder } from './finder';
import { supportedStorageMetadatas } from './supported';
import { GraphQLException } from 'src/graphql.exception';

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
      rejectOnNotFound: () => new GraphQLException(ERROR_CODE_STORAGE_NOT_FOUND),
    });

    return this.createObjectURLBylocation(location, options);
  }

  /**
   * Validate storage, and return pinned used callback.
   */
  async validate(
    storageId: string,
    ownerId: string,
    metadatas: SupportedStorageMetadata[] = supportedStorageMetadatas,
  ): Promise<() => Prisma.Prisma__StorageClient<Storage>> {
    /// Find storage
    const storaged = await this.prisma.storage.findUnique({
      where: { id: storageId },
      rejectOnNotFound: () => new GraphQLException(ERROR_CODE_STORAGE_NOT_FOUND),
    });

    /// If storage is used, throw error
    if (storaged.isUsed) {
      throw new GraphQLException(ERROR_CODE_STORAGE_IS_USED);
    }

    // If storage ownerId is not equal to ownerId, throw error
    if (storaged.ownerId !== ownerId) {
      throw new GraphQLException(ERROR_CODE_STORAGE_NOT_FOUND);
    }

    // Get object uploaded http result.
    const result = await this.headObject({
      Bucket: this.configure.bucket!,
      Region: this.configure.region!,
      Key: storaged.location,
    });

    // If http code is not 200, throw error
    if (result.statusCode !== 200) {
      throw new GraphQLException(ERROR_CODE_STORAGE_NOT_UPLOADED);
    }

    // Get object content-type in headers
    const contentType: string | undefined = ObjectHelper.value(
      result.headers ?? {},
      'content-type',
    );

    // If contentType is empty, throw error
    if (!contentType) {
      throw new GraphQLException(ERROR_CODE_STORAGE_UNKNOWN_MIME_TYPE);
    }

    // Get current storage metadata
    const metadata = finder(contentType);

    // Match contentType with supported metadata
    if (!metadatas.includes(metadata)) {
      throw new GraphQLException(ERROR_CODE_STORAGE_UNSUPPORTED_MIME_TYPE);
    }

    return () =>
      this.prisma.storage.update({
        where: { id: storageId },
        data: { isUsed: true },
      });
  }

  /**
   * Delete storage or clear unused storages.
   */
  async deleteAndClear(storageId?: string | null): Promise<void> {
    if (UtilHelpers.isNotEmpty(storageId)) {
      await this.prisma.storage.delete({
        where: { id: storageId! },
      });
    }

    await this.prisma.storage.deleteMany({
      where: {
        AND: [
          // Unused
          { isUsed: false },
          // Older than 3 days
          { createdAt: { lt: new Date(Date.now() - 1000 * 60 * 60 * 24 * 3) } },
        ],
      },
    });
  }
}
