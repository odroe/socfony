import { Client } from "tencentcloud-sdk-nodejs/tencentcloud/services/sms/v20210111/sms_client";
import { SendSmsRequest } from "tencentcloud-sdk-nodejs/tencentcloud/services/sms/v20210111/sms_models";
import { getCredential } from "./credential";
import { tencentCloudStorageBox } from "./storage-box";

export namespace SMS {
  let internal: Client;

  async function getClient(): Promise<Client> {
    const credential = await getCredential();
    if (
      internal &&
      internal.credential.secretId === credential.secretId &&
      internal.credential.secretKey === credential.secretKey
    ) {
      return internal;
    }

    return (internal = new Client({
      credential,
      region: "ap-shanghai",
    }));
  }

  async function getRequest(
    phone: string,
    code: string
  ): Promise<SendSmsRequest> {
    const request = await tencentCloudStorageBox.get<SendSmsRequest>(
      "validate-user-sms"
    );
    request.TemplateParamSet = request.TemplateParamSet?.map((value) =>
      value.replace("{code}", code)
    );
    request.PhoneNumberSet = [phone];

    return request;
  }

  export async function send(phone: string, code: string) {
    // Get SendSmsRequest config
    const request = await getRequest(phone, code);
    const client = await getClient();

    return await client.SendSms(request);
  }
}
