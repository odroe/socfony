import { Injectable } from '@nestjs/common';
import { StorageBox } from 'src/storage-box';
import { StorageBoxInterface } from 'storage-box';
import { Client } from 'tencentcloud-sdk-nodejs/tencentcloud/services/sms/v20210111/sms_client';
import {
  SendSmsRequest,
  SendSmsResponse,
} from 'tencentcloud-sdk-nodejs/tencentcloud/services/sms/v20210111/sms_models';
import { Credential } from 'tencentcloud-sdk-nodejs/tencentcloud/common/interface';

@Injectable()
export class SmsClient {
  constructor(
    @StorageBox('sms') private readonly smsStorageBox: StorageBoxInterface,
    @StorageBox('vendor')
    private readonly vendorStorageBox: StorageBoxInterface,
  ) {}

  async #createClient(): Promise<Client> {
    const credential = await this.vendorStorageBox.get<Credential>(
      'tencentcloud',
    );
    const region = await this.smsStorageBox.get<string>('region');

    return new Client({
      credential,
      region,
      profile: {},
    });
  }

  async send(
    phone: string,
    args: {
      context?: string;
      code: string;
      term: number;
    },
  ): Promise<SendSmsResponse> {
    const client = await this.#createClient();
    const params = await this.smsStorageBox.get<
      Pick<
        SendSmsRequest,
        | 'ExtendCode'
        | 'SenderId'
        | 'SignName'
        | 'SmsSdkAppId'
        | 'TemplateId'
        | 'TemplateParamSet'
      >
    >('params');

    const templateParamSet = params.TemplateParamSet.map((param) =>
      param
        .replace('{code}', args.code)
        // https://cloud.tencent.com/document/product/382/39023#.E5.8F.98.E9.87.8F.E8.A7.84.E8.8C.83.3Ca-id.3D.22variable.22.3E.3C.2Fa.3E
        // 限制为纯数字
        .replace('{term}', `${args.term / 60}`),
    );

    return await client.SendSms({
      ...params,
      PhoneNumberSet: [phone],
      SessionContext: args.context,
      TemplateParamSet: templateParamSet,
    });
  }
}
