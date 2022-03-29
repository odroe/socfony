import { Inject, Injectable } from '@nestjs/common';
import { ConfigType } from '@nestjs/config';
import COS = require('cos-nodejs-sdk-v5');
import * as qs from 'qs';
import tencent_cos from 'src/configuration/tencent_cos';

@Injectable()
export class COSService {
  constructor(
    @Inject(tencent_cos.KEY)
    private readonly configure: ConfigType<typeof tencent_cos>,
  ) {}

  /**
   * Create a COS client.
   * @returns {Promise<COS>}
   */
  async createClient(): Promise<COS> {
    return new COS({
      SecretId: this.configure.secretId,
      SecretKey: this.configure.secretKey,
      Protocol: this.configure.protocol,
      Domain: this.configure.domain,
    });
  }

  async createDowenloadUrl(path: string, query?: string): Promise<string> {
    const client = await this.createClient();
    const queryObject = query ? qs.parse(query) : {};

    const options: COS.GetObjectUrlParams = {
      Key: path,
      Query: queryObject,
      Region: this.configure.region!,
      Bucket: this.configure.bucket!,
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

    const options: COS.GetObjectUrlParams = {
      Key: path,
      Region: this.configure.region!,
      Bucket: this.configure.bucket!,
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
}
