import { Injectable } from '@nestjs/common';
import dayjs = require('dayjs');
import { customAlphabet } from 'nanoid';
import { StorageBox } from 'src/storage-box';
import { StorageBoxInterface } from 'storage-box';
import { Credential } from 'tencentcloud-sdk-nodejs/tencentcloud/common/interface';
import { Client } from 'tencentcloud-sdk-nodejs/tencentcloud/services/sts/v20180813/sts_client';
import { GetFederationTokenResponse } from 'tencentcloud-sdk-nodejs/tencentcloud/services/sts/v20180813/sts_models';
import { FederationToken } from './entittes/federation-token.entity';

@Injectable()
export class MediaService {
  constructor(
    @StorageBox('vendor')
    private readonly vendorBox: StorageBoxInterface,
    @StorageBox('cos')
    private readonly cosBox: StorageBoxInterface,
  ) {}

  async #createClient(region: string): Promise<Client> {
    const credential = await this.vendorBox.get<Credential>('tencentcloud');

    return new Client({ credential, region, profile: {} });
  }

  #createResponse(response: GetFederationTokenResponse): FederationToken {
    return {
      expiredTime: response.ExpiredTime,
      expiredAt: dayjs(response.Expiration).toDate(),
      token: response.Credentials.Token,
      secretId: response.Credentials.TmpSecretId,
      secretKey: response.Credentials.TmpSecretKey,
    };
  }

  async download(resource: string): Promise<FederationToken> {
    const region = await this.cosBox.get<string>('region');
    const bucket = await this.cosBox.get<string>('bucket');
    const { download } = await this.cosBox.get<{ download: number }>(
      'duration',
    );
    const client = await this.#createClient(region);

    const uid = bucket.split('-')[1];

    const response = await client.GetFederationToken({
      Name: customAlphabet('qwertyuiopasdfghjklzxcvbnm', 32)(),
      DurationSeconds: parseInt(`${download || 7200}`),
      Policy: JSON.stringify({
        version: '2.0',
        statement: [
          {
            action: ['name/cos:HeadObject', 'name/cos:GetObject'],
            effect: 'allow',
            resource: [`qcs::cos:${region}:uid/${uid}:${bucket}/${resource}`],
          },
        ],
      }),
    });

    return this.#createResponse(response);
  }

  async upload(resource: string): Promise<FederationToken> {
    const region = await this.cosBox.get<string>('region');
    const bucket = await this.cosBox.get<string>('bucket');
    const { upload } = await this.cosBox.get<{ upload: number }>('duration');
    const client = await this.#createClient(region);

    const uid = bucket.split('-')[1];

    const response = await client.GetFederationToken({
      Name: customAlphabet('qwertyuiopasdfghjklzxcvbnm', 32)(),
      DurationSeconds: parseInt(`${upload || 1800}`),
      Policy: JSON.stringify({
        version: '2.0',
        statement: [
          {
            action: [
              'name/cos:PutObject',
              'name/cos:PostObject',
              'name/cos:InitiateMultipartUpload',
              'name/cos:ListMultipartUploads',
              'name/cos:ListParts',
              'name/cos:UploadPart',
              'name/cos:CompleteMultipartUpload',
              'name/cos:AbortMultipartUpload',
            ],
            effect: 'allow',
            resource: [`qcs::cos:${region}:uid/${uid}:${bucket}/${resource}`],
          },
        ],
      }),
    });

    return this.#createResponse(response);
  }
}
