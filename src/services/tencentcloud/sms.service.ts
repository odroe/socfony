import { Inject, Injectable } from '@nestjs/common';
import { ConfigType } from '@nestjs/config';
import { tencentcloud } from 'src/configuration';
import { sms } from 'tencentcloud-sdk-nodejs-sms';

export interface SendOneTimePasswordTencentCloudShortMessageOptions {
  password: string;
  expiresIn: number;
}

@Injectable()
export class TencentCloudShortMessageService extends sms.v20210111.Client {
  constructor(
    @Inject(tencentcloud.sms.KEY)
    private readonly configure: ConfigType<typeof tencentcloud.sms>,
  ) {
    super({
      credential: {
        secretId: configure.secretId,
        secretKey: configure.secretKey,
      },
      region: configure.region,
    });
  }

  async sendOneTimePassword(
    phone: string,
    options: SendOneTimePasswordTencentCloudShortMessageOptions,
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
            return options.expiresIn.toString();
          default:
            return value;
        }
      }),
    });
  }
}
