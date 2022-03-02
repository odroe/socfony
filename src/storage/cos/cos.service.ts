import { Injectable } from '@nestjs/common';
import { PrismaClient } from '@prisma/client';
import COS from 'cos-nodejs-sdk-v5';
import qs from 'qs';

@Injectable()
export class COSService {
  constructor(private readonly prisma: PrismaClient) {}

  /**
   * Create a COS client.
   * @returns {Promise<COS>}
   */
  async createClient(): Promise<COS> {
    // Fetch COS secretId and secretKey from Prisma.
    const colum = await this.prisma.setting.findUnique({
      where: {
        type_key: {
          type: 'cos',
          key: 'base',
        },
      },
      rejectOnNotFound: () =>
        new Error('COS secretId and secretKey not found.'),
    });
    const { secretId, secretKey, domain, protocol } = colum.value as {
      secretId: string;
      secretKey: string;
      domain: string | null;
      protocol: string;
    };

    return new COS({
      SecretId: secretId,
      SecretKey: secretKey,
      Protocol: protocol,
      Domain: typeof domain === 'string' ? domain : undefined,
    });
  }

  async createDowenloadUrl(path: string, query?: string): Promise<string> {
    const client = await this.createClient();
    const { bucket, region } = await this.configure();
    const queryObject = query ? qs.parse(query) : {};

    const options: COS.GetObjectUrlParams = {
      Key: path,
      Query: queryObject,
      Region: region,
      Bucket: bucket,
      Sign: true,
      Expires: 60 * 60 * 24,
      Method: 'GET',
    };

    return new Promise<string>((resolve, reject) =>
      client.getObjectUrl(options, (err, data) => {
        if (err) {
          return reject(new Error(err.message));
        }

        resolve(data.Url);
      }),
    );
  }

  /**
   * Create upload url.
   * @param path COS file path.
   * @param headers Put object headers.
   * @returns string
   */
  async createUploadUrl(
    path: string,
    headers: Record<string, any>,
  ): Promise<string> {
    const client = await this.createClient();
    const { bucket, region } = await this.configure();

    const options: COS.GetObjectUrlParams = {
      Key: path,
      Region: region,
      Bucket: bucket,
      Sign: true,
      Expires: 60 * 30,
      Method: 'PUT',
      Headers: headers,
    };

    return new Promise<string>((resolve, reject) =>
      client.getObjectUrl(options, (err, data) => {
        if (err) {
          return reject(new Error(err.message));
        }

        resolve(data.Url);
      }),
    );
  }

  protected async configure(): Promise<{
    bucket: string;
    region: string;
  }> {
    const colum = await this.prisma.setting.findUnique({
      where: {
        type_key: {
          type: 'cos',
          key: 'configure',
        },
      },
      rejectOnNotFound: () => new Error('COS configure not found.'),
    });

    return colum.value as { bucket: string; region: string };
  }
}
