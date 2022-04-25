import { registerAs } from '@nestjs/config';

export default registerAs('Tencent Cloud SMS', () => ({
  appId: process.env.TENCENTCLOUD_SMS_APPID,
  signName: process.env.TENCENTCLOUD_SMS_SIGN_NAME,
  templateId: process.env.TENCENTCLOUD_SMS_TEMPLATE_ID,
  params:
    process.env.TENCENTCLOUD_SMS_PARAMS?.split(',').map((item) =>
      item.trim(),
    ) || [],
  region: process.env.TENCENTCLOUD_SMS_REGION,
  secretId: process.env.TENCENTCLOUD_SMS_SECRET_ID,
  secretKey: process.env.TENCENTCLOUD_SMS_SECRET_KEY,
}));
