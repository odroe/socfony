import { Inject, Injectable } from '@nestjs/common';
import { ConfigType } from '@nestjs/config';
import { tencentcloud } from 'src/configuration';
import { ses } from 'tencentcloud-sdk-nodejs-ses';

export interface SendOneTimePasswordTencendCloudSimpleEmailOptions {
  password: string;
  expiresIn: number;
}

@Injectable()
export class TencentCloudSimpleEmailService extends ses.v20201002.Client {
  constructor(
    @Inject(tencentcloud.ses.KEY)
    private readonly configure: ConfigType<typeof tencentcloud.ses>,
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
    to: string,
    options: SendOneTimePasswordTencendCloudSimpleEmailOptions,
  ): Promise<void> {
    await this.SendEmail({
      FromEmailAddress: this.configure.sender,
      Destination: [to],
      Subject: this.configure.subject,
      TriggerType: 1,
      Template: {
        TemplateID: this.configure.templateId,
        TemplateData: JSON.stringify({
          [this.configure.params.otp]: options.password,
          [this.configure.params.minutes]: options.expiresIn,
        }),
      },
    });
  }
}
