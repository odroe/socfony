import { forwardRef, Inject, Injectable } from '@nestjs/common';
import { OneTimePasswordType, PrismaClient } from '@prisma/client';
import { Client } from 'tencentcloud-sdk-nodejs/tencentcloud/services/sms/v20210111/sms_client';
import { ClientConfig } from 'tencentcloud-sdk-nodejs/tencentcloud/common/interface';
import { OneTimePasswordService } from '../one-time-password.service';

@Injectable()
export class SMSService {
  constructor(
    private readonly prisma: PrismaClient,
    @Inject(forwardRef(() => OneTimePasswordService))
    private readonly otpService: OneTimePasswordService,
  ) {}

  protected async clientConfig(): Promise<ClientConfig> {
    const setting = await this.prisma.setting.findUnique({
      where: {
        type_key: {
          type: 'sms',
          key: 'tencentcloud-sms-client',
        },
      },
      rejectOnNotFound: false,
    });

    return setting?.value as unknown as ClientConfig;
  }

  protected async requestConfig(): Promise<{
    appId: string;
    templateId: string;
    signName: string;
    params: string[];
  }> {
    const setting = await this.prisma.setting.findUnique({
      where: {
        type_key: {
          type: 'sms',
          key: 'tencentcloud-sms-request',
        },
      },
      rejectOnNotFound: false,
    });

    return setting?.value as unknown as {
      appId: string;
      templateId: string;
      signName: string;
      params: string[];
    };
  }

  async client(): Promise<Client> {
    const config = await this.clientConfig();
    return new Client(config);
  }

  async send(phone: string): Promise<void> {
    const otp = await this.otpService.save({
      type: OneTimePasswordType.SMS,
      value: phone,
      expiredAt: new Date(Date.now() + 1000 * 60 * 5),
    });
    const { appId, templateId, signName, params } = await this.requestConfig();

    const client = await this.client();
    await client.SendSms({
      PhoneNumberSet: [phone],
      SmsSdkAppId: appId,
      TemplateId: templateId,
      SignName: signName,
      TemplateParamSet: params.map((value) => {
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
