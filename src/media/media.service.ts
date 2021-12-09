import { Injectable } from '@nestjs/common';
import { PrismaClient, Prisma } from '@prisma/client';
import COS = require('cos-nodejs-sdk-v5');

@Injectable()
export class MediaService {
  constructor(private readonly prisma: PrismaClient) {}

  private async getOptions(): Promise<Prisma.JsonObject> {
    const row = await this.prisma.configuration.findUnique({
      where: { key: 'tencentcloud-cos' },
      rejectOnNotFound: () =>
        new Error('Tencent cloud COS configuration not found'),
    });

    return row.value as Prisma.JsonObject;
  }

  private async getClient(options: Prisma.JsonObject): Promise<COS> {
    return new COS({
      SecretId: options.secretId as string,
      SecretKey: options.secretKey as string,
      Domain: options.domain as string,
    });
  }

  async createUploadUrl(
    key: string,
    md5: string,
    length: number,
  ): Promise<string> {
    const options = await this.getOptions();
    const client = await this.getClient(options);
    const request: COS.GetObjectUrlParams = {
      Bucket: options.bucket as string,
      Region: options.region as string,
      Key: key,
      Expires: 60 * 60,
      Sign: true,
      Method: 'PUT',
      Headers: {
        'Content-MD5': md5,
        'Content-Length': length,
      },
    };

    return new Promise((resolve, reject) => {
      client.getObjectUrl(request, (err, data) => {
        if (err) {
          return reject(err);
        }

        resolve(data.Url);
      });
    });
  }

  async createDownloadUrl(key: string, query?: string): Promise<string> {
    const options = await this.getOptions();
    const client = await this.getClient(options);
    const request: COS.GetObjectUrlParams = {
      Bucket: options.bucket as string,
      Region: options.region as string,
      Key: key,
      Expires: 60 * 60,
      Sign: true,
      Method: 'GET',
      QueryString: query,
    };

    return new Promise((resolve, reject) => {
      client.getObjectUrl(request, (err, data) => {
        if (err) {
          return reject(err);
        }

        resolve(data.Url);
      });
    });
  }

  async exists<T extends string>(
    key: T | T[],
    where?: (data?: COS.HeadObjectResult) => boolean,
  ): Promise<Record<T, boolean>> {
    const keys = Array.isArray(key) ? key : [key];
    const options = await this.getOptions();
    const client = await this.getClient(options);
    const results = {} as Record<T, boolean>;

    for await (const value of keys) {
      const request: COS.HeadObjectParams = {
        Bucket: options.bucket as string,
        Region: options.region as string,
        Key: value,
      };

      results[value] = await new Promise((resolve, reject) => {
        client.headObject(request, (err, data) => {
          if (where) {
            return resolve(where(data));
          }

          resolve(!err && data.statusCode === 200);
        });
      });
    }

    return results;
  }
}
