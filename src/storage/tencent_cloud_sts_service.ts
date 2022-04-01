import { Inject, Injectable } from '@nestjs/common';
import { Client } from 'tencentcloud-sdk-nodejs/tencentcloud/services/sts/v20180813/sts_client';
import tencentCloudObjectStorageConfigure from 'src/configuration/tencent_cloud_object_storage';
import { ConfigType } from '@nestjs/config';
import { nanoid } from 'nanoid';
import { FederationToken } from './entities/federation_token';

@Injectable()
export class TencentCloudSTSClient extends Client {
  constructor(
    @Inject(tencentCloudObjectStorageConfigure.KEY)
    private readonly configure: ConfigType<
      typeof tencentCloudObjectStorageConfigure
    >,
  ) {
    super({
      credential: {
        secretId: configure.secretId,
        secretKey: configure.secretKey,
      },
      region: configure.region!,
      profile: {
        signMethod: 'TC3-HMAC-SHA256',
        httpProfile: {
          reqMethod: 'POST',
        },
      },
    });
  }

  get appid(): string {
    return this.configure.bucket!.split('-')[1];
  }

  async createUploadFederationToken(): Promise<FederationToken> {
    const prefix = `temp/${nanoid(64)}`;
    const resource: string[] = [
      `qcs::cos:uid/${this.appid}:${this.configure.bucket}/${prefix}/*`,
    ];

    const response = await this._createFederationToken({
      version: '2.0',
      statement: [
        {
          effect: 'allow',
          action: ['cos:PutObject', 'cps:PostObject'],
          resource,
        },
      ],
    });
    const federationToken = new FederationToken();
    federationToken.expiredAt = new Date(response.Expiration!);
    federationToken.token = response.Credentials!.Token;
    federationToken.secretId = response.Credentials!.TmpSecretId!;
    federationToken.secretKey = response.Credentials!.TmpSecretKey!;
    federationToken.prefix = [prefix];

    return federationToken;
  }

  async createDownloadFederationToken(
    userId?: string,
  ): Promise<FederationToken> {
    const prefix: string[] = ['public'];
    const resource: string[] = [
      `qcs::cos::uid/${this.appid}:${this.configure.bucket}/public/*`,
    ];
    if (userId) {
      resource.push(
        `qcs::cos::uid/${this.appid}:${this.configure.bucket}/private/${userId}/*`,
      );
      prefix.push(`private/${userId}`);
    }

    const response = await this._createFederationToken({
      version: '2.0',
      statement: [
        {
          effect: 'allow',
          action: [
            'cos:HeadObject',
            'cos:GetObject',
            'cos:OptionsObject',
            'cos:GetObjectTagging',
          ],
          resource,
        },
      ],
    });
    const federationToken = new FederationToken();
    federationToken.expiredAt = new Date(response.Expiration!);
    federationToken.token = response.Credentials!.Token;
    federationToken.secretId = response.Credentials!.TmpSecretId!;
    federationToken.secretKey = response.Credentials!.TmpSecretKey!;
    federationToken.prefix = prefix;

    return federationToken;
  }

  private _createFederationToken(policy: Object) {
    return this.GetFederationToken({
      Name: nanoid(64),
      DurationSeconds: 7200,
      Policy: JSON.stringify(policy),
    });
  }
}
