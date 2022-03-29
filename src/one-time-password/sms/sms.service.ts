import { Inject, Injectable } from '@nestjs/common';
import { ConfigType } from '@nestjs/config';
import { OneTimePasswordType } from '@prisma/client';
import tencent_cloud_sms from 'src/configuration/tencent_cloud_sms';
import { Client } from 'tencentcloud-sdk-nodejs/tencentcloud/services/sms/v20210111/sms_client';
import { OTPCommonService } from '../common';

@Injectable()
export class SMSService {
  constructor(
    private readonly common: OTPCommonService,
    @Inject(tencent_cloud_sms.KEY)
    private readonly configure: ConfigType<typeof tencent_cloud_sms>,
  ) {}

  client(): Client {
    return new Client({
      credential: {
        secretId: this.configure.secretId,
        secretKey: this.configure.secretKey,
      },
      region: this.configure.region!,
      profile: {},
    });
  }

  async send(phone: string): Promise<void> {
    const otp = await this.common.save({
      type: OneTimePasswordType.SMS,
      value: phone,
      expiredAt: new Date(Date.now() + 1000 * 60 * 5),
    });

    await this.client().SendSms({
      PhoneNumberSet: [phone],
      SmsSdkAppId: this.configure.appId!,
      TemplateId: this.configure.templateId!,
      SignName: this.configure.signName!,
      TemplateParamSet: this.configure.params.map((value) => {
        switch (value.toLocaleLowerCase()) {
          case '{otp}':
            return otp;
          case '{minutes}':
            return '5';
          default:
            return value;
        }
      }),
    });
  }
}
