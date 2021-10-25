import { PrismaClient } from '@prisma/client';
import { Injectable } from '@nestjs/common';

import { Credential } from 'tencentcloud-sdk-nodejs/tencentcloud/common/interface';
import { Client } from 'tencentcloud-sdk-nodejs/tencentcloud/services/sms/v20210111/sms_client';
import { SendSmsResponse } from 'tencentcloud-sdk-nodejs/tencentcloud/services/sms/v20210111/sms_models';

import { SendSmsMessageOptions } from './send-sms-message.options';

@Injectable()
export class TencentcloudSmsService {
  constructor(private readonly prisma: PrismaClient) {}

  async send(message: SendSmsMessageOptions): Promise<SendSmsResponse> {
    const client = await this.getClient();

    return client.SendSms(message.toRequest());
  }

  async getTencentCloudCredential(): Promise<Credential> {
    const credential = await this.prisma.setting.findUnique({
      where: { key: 'tencentcloud' },
    });

    if (
      !credential ||
      !credential.value ||
      !(credential.value as Credential).secretId ||
      !(credential.value as Credential).secretKey
    ) {
      throw new Error('TencentCloud credential not found');
    }

    return credential.value as Credential;
  }

  async getClient(): Promise<Client> {
    const credential = await this.getTencentCloudCredential();

    return new Client({
      credential,
      region: 'ap-guangzhou',
      profile: {},
    });
  }
}
