import { SendSmsRequest } from 'tencentcloud-sdk-nodejs/tencentcloud/services/sms/v20210111/sms_models';

export abstract class SendSmsMessageOptions {
  abstract getPhoneNumberSet(): string[];

  abstract getAppId(): string;

  abstract getTemplateId(): string;

  abstract getSignName(): string;

  abstract getTemplateParamSet(): string[];

  toRequest(): SendSmsRequest {
    return {
      PhoneNumberSet: this.getPhoneNumberSet(),
      SignName: this.getSignName(),
      TemplateId: this.getTemplateId(),
      SmsSdkAppId: this.getAppId(),
      TemplateParamSet: this.getTemplateParamSet(),
    };
  }
}
