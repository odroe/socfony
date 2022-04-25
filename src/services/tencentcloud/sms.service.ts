import { Inject, Injectable } from '@nestjs/common';
import { ConfigType } from '@nestjs/config';
import { tencentcloud } from 'src/configuration';
import { Client } from 'tencentcloud-sdk-nodejs/tencentcloud/services/sms/v20210111/sms_client';

export interface TencentCloudSMSSendOptions {
  password: string;
  expiredAt: Date;
}

@Injectable()
export class TencentCloudSMSService extends Client {
  constructor(
    @Inject(tencentcloud.sms.KEY)
    private readonly configure: ConfigType<typeof tencentcloud.sms>,
  ) {
    super({
      credential: {
        secretId: configure.secretId,
        secretKey: configure.secretKey,
      },
      region: configure.region!,
      profile: {},
    });
  }

  async send(
    phone: string,
    options: TencentCloudSMSSendOptions,
  ): Promise<void> {
    await this.SendSms({
      PhoneNumberSet: [phone],
      SmsSdkAppId: this.configure.appId!,
      TemplateId: this.configure.templateId!,
      SignName: this.configure.signName!,
      TemplateParamSet: this.configure.params.map((value) => {
        switch (value.toLocaleLowerCase()) {
          case '{otp}':
            return options.password;
          case '{minutes}':
            const now = new Date();
            const minutes = Math.floor(
              (options.expiredAt.getTime() - now.getTime()) / 1000 / 60,
            );
            return minutes.toString();
          default:
            return value;
        }
      }),
    });
  }
}
