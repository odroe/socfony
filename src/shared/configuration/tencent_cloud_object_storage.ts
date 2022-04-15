import { registerAs } from '@nestjs/config';

export default registerAs('Tencent Cloud Object Storage', () => ({
  secretId: process.env.TENCENTCLOUD_COS_SECRET_ID,
  secretKey: process.env.TENCENTCLOUD_COS_SECRET_KEY,
  region: process.env.TENCENTCLOUD_COS_REGION,
  bucket: process.env.TENCENTCLOUD_COS_BUCKET,
  domain: process.env.TENCENTCLOUD_COS_DOMAIN,
  protocol: process.env.TENCENTCLOUD_COS_PROTOCOL || 'https',
}));
