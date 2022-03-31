import { ConfigModule } from '@nestjs/config';

import auth from './auth';
import mailer from './mailer';
import database from './database';
import grapgql from './graphql';
import server from './server';
import tencent_cos from './tencent_cloud_object_storage';
import tencent_cloud_sms from './tencent_cloud_sms';

export const ConfigureModule = ConfigModule.forRoot({
  isGlobal: true,
  envFilePath: ['.env'],
  load: [
    auth,
    mailer,
    database,
    grapgql,
    server,
    tencent_cos,
    tencent_cloud_sms,
  ],
});
