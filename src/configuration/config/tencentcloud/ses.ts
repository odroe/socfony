import { registerAs } from "@nestjs/config";
import { intParser } from "../../utils";

export default registerAs('Tencent Cloud SES', () => ({
  secretId: process.env.TENCENTCLOUD_SES_SECRET_ID,
  secretKey: process.env.TENCENTCLOUD_SES_SECRET_KEY,
  sender: process.env.TENCENTCLOUD_SES_SENDER!,
  subject: process.env.TENCENTCLOUD_SES_SUBJECT!,
  templateId: intParser(process.env.TENCENTCLOUD_SES_TEMPLATE_ID)!,
  params: {
    otp: process.env.TENCENTCLOUD_SES_PARAM_OTP!,
    minutes: process.env.TENCENTCLOUD_SES_PARAM_MINUTES!,
  },
  region: process.env.TENCENTCLOUD_SES_REGION!,
}));