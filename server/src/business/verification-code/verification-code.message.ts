import { PrismaClient } from '@prisma/client';
import * as dayjs from 'dayjs';
import { customAlphabet } from 'nanoid';
import { SendSmsMessageOptions } from 'src/shared';

interface DatebaseSettingOptions {
  appId: string;
  temaplateId: string;
  signName: string;
  templateParams: string[];
  minutes: number;
}

export class VerificationCodeMessage extends SendSmsMessageOptions {
  readonly code: string;

  constructor(
    readonly to: string,
    private readonly options: DatebaseSettingOptions,
  ) {
    super();
    this.code = customAlphabet('1234567890', 6)();
  }

  getPhoneNumberSet(): string[] {
    return [this.to];
  }

  getAppId(): string {
    return this.options.appId;
  }

  getTemplateId(): string {
    return this.options.temaplateId;
  }

  getSignName(): string {
    return this.options.signName;
  }

  getTemplateParamSet(): string[] {
    return this.options.templateParams.map((param) => {
      switch (param) {
        case '<code>':
          return this.code;
        case '<minutes>':
          return this.options.minutes.toString();
        default:
          return param;
      }
    });
  }

  getExpiredAt(): Date {
    return dayjs().add(this.options.minutes, 'minute').toDate();
  }

  static async createMessage(
    prisma: PrismaClient,
    to: string,
  ): Promise<VerificationCodeMessage> {
    const options = await prisma.setting.findUnique({
      where: { key: 'tencentcloud-sms' },
      rejectOnNotFound: false,
    });

    if (!options || !options.value) {
      throw new Error('Tencent cloud SMS setting not found');
    }

    return new VerificationCodeMessage(
      to,
      options.value as unknown as DatebaseSettingOptions,
    );
  }
}
