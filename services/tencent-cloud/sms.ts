import { Client } from "tencentcloud-sdk-nodejs/tencentcloud/services/sms/v20210111/sms_client";
import { Credential } from "tencentcloud-sdk-nodejs/tencentcloud/common/interface";
import { SendSmsRequest } from "tencentcloud-sdk-nodejs/tencentcloud/services/sms/v20210111/sms_models";
import { tencentCloudStorageBox } from "./storage-box";

/**
 * SMS config
 */
export interface SmsConfig {
  credential: Omit<Credential, "token">;
  region: string;
  request: Omit<SendSmsRequest, "PhoneNumberSet">;
}

/**
 * Get SMS config.
 */
function getConfig(): Promise<SmsConfig> {
  return tencentCloudStorageBox.get<SmsConfig>("send-validate-user-sms");
}

/**
 * Send a SMS to user.
 * @param phone Phone number.
 * @param code Code.
 * @returns Send status.
 * @throws Error if send failed.
 */
export async function sendValidateUserSms(phone: string, code: string) {
  // Get config.
  const { request, ...clientOptions } = await getConfig();

  // Create client.
  const client = new Client(clientOptions);

  // Create SMS template params.
  const params =
    request.TemplateParamSet?.map((item) => item.replace("{code}", code)) || [];

  // Create SMS send params.
  const options: SendSmsRequest = Object.assign({}, request, {
    TemplateParamSet: [phone],
    PhoneNumberSet: params,
  });

  // Send SMS.
  const response = await client.SendSms(options);

  return response.SendStatusSet.pop();
}
