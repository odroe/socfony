import { ConfigModule } from '@nestjs/config';

import auth from './config/auth';
import mailer from './config/mailer';
import server from './config/server';
import tencent_cos from './config/tencentcloud/cos';
import tencent_cloud_sms from './config/tencentcloud/sms';

export const ConfigureModule = ConfigModule.forRoot({
  isGlobal: true,
  envFilePath: ['.env'],
  load: [auth, mailer, server, tencent_cos, tencent_cloud_sms],
});
