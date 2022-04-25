// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Module } from '@nestjs/common';
import { ConfigureModule } from '../configuration/configure.module';
import { GraphQLModule } from '../shared/graphql';
import { AuthModule, PrismaModule } from '../shared';
import { AccessTokenModule } from './modules/access-token/access-token.module';
import { UserModule } from './modules/user/user.module';
import { OneTimePasswordModule } from './modules/one-time-password';
import { StorageModule } from './modules/storage/storage.module';
import { MomentsModule } from './modules/moments/moments.module';

@Module({
  imports: [
    ConfigureModule,
    GraphQLModule,
    PrismaModule.forRoot(),
    AuthModule.forRoot(),
    AccessTokenModule,
    UserModule,
    OneTimePasswordModule,
    StorageModule,
    MomentsModule,
  ],
})
export class AppModule {}
