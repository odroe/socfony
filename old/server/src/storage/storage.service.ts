import { Injectable } from '@nestjs/common';
import { PrismaClient } from '@prisma/client';
import COS = require('cos-nodejs-sdk-v5');

type TencentCloudOptions = Pick<COS.COSOptions, 'SecretId' | 'SecretKey'>;

type CosOptions = {
  Bucket: string;
  Region: string;
};

export type CreateUploadLinkOptions = {
  key: string;
  md5: string;
  length: number;
};

@Injectable()
export class StorageService {
  constructor(private readonly prisma: PrismaClient) {}

  protected async client(): Promise<COS> {
    return new COS({
      ...(await this.getTencentCloudOptions()),
      Domain: await this.getCosDomain(),
    });
  }

  private async getTencentCloudOptions(): Promise<TencentCloudOptions> {
    const credential = await this.prisma.configuration.findUnique({
      where: { key: 'tencentcloud' },
      rejectOnNotFound: () => new Error('腾讯云配置没有找到'),
    });

    if (
      !credential ||
      !credential.value ||
      !credential.value['secretId'] ||
      !credential.value['secretKey']
    ) {
      throw new Error('腾讯云配置没有找到');
    }

    return {
      SecretId: credential.value['secretId'],
      SecretKey: credential.value['secretKey'],
    };
  }

  protected async getCosOptions(): Promise<CosOptions> {
    const configuration = await this.prisma.configuration.findUnique({
      where: { key: 'tencentcloud-cos' },
      rejectOnNotFound: () => new Error('腾讯云 COS 配置没有找到'),
    });

    if (
      !configuration ||
      !configuration.value ||
      !configuration.value['bucket'] ||
      !configuration.value['region']
    ) {
      throw new Error('腾讯云 COS 配置没有找到');
    }

    return {
      Bucket: configuration.value['bucket'],
      Region: configuration.value['region'],
    };
  }

  protected async getCosDomain(): Promise<string | null> {
    const configuration = await this.prisma.configuration.findUnique({
      where: { key: 'tencentcloud-cos' },
      rejectOnNotFound: false,
    });

    if (
      !configuration ||
      !configuration.value ||
      !configuration.value['domain']
    ) {
      return null;
    }

    return configuration.value['domain'];
  }

  public async createUploadLink({
    key,
    md5,
    length,
  }: CreateUploadLinkOptions): Promise<string> {
    const client = await this.client();
    const cosOptions = await this.getCosOptions();
    const options: COS.GetObjectUrlParams = {
      ...cosOptions,
      Key: key,
      Sign: true,
      Expires: 3600,
      Method: 'PUT',
      Headers: {
        'Content-Length': length,
        'Content-MD5': md5,
      },
    };

    return new Promise<string>((resolve, reject) => {
      client.getObjectUrl(options, (err, data) => {
        if (err) {
          return reject(err);
        }

        resolve(data.Url);
      });
    });
  }

  public async createDownloadLink({
    key,
    query,
  }: {
    key: string;
    query?: string;
  }): Promise<string> {
    const client = await this.client();
    const cosOptions = await this.getCosOptions();
    const options: COS.GetObjectUrlParams = {
      ...cosOptions,
      Key: key,
      Sign: true,
      Expires: 3600,
      Method: 'GET',
      QueryString: query,
    };

    return new Promise<string>((resolve, reject) => {
      client.getObjectUrl(options, (err, data) => {
        if (err) {
          return reject(err);
        }

        resolve(data.Url);
      });
    });
  }

  public async exists<T extends string>(
    key: T | readonly T[],
    where?: (data?: COS.HeadObjectResult) => boolean,
  ): Promise<Record<T, boolean>> {
    const keys: string[] = Array.isArray(key) ? key : [key];
    const client = await this.client();
    const cosOptions = await this.getCosOptions();

    const result = {} as Record<T, boolean>;
    for await (const value of keys) {
      const options: COS.HeadObjectParams = {
        ...cosOptions,
        Key: value,
      };
      result[value] = await new Promise<boolean>((resolve) => {
        client.headObject(options, (err, data) => {
          if (where) {
            return resolve(where(data));
          }

          resolve(!err && data.statusCode === 200);
        });
      });
    }

    return result;
  }
}
