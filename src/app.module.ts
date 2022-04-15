// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Module } from '@nestjs/common';
import { ConfigureModule } from './shared/configuration/configure_module';
import { GraphQLModule } from './shared/graphql';
import { AuthModule, PrismaModule } from './shared';
import { AccessTokenModule } from './access-token/access-token.module';
import { UserModule } from './user/user.module';
import { OneTimePasswordModule } from './one-time-password';
import { StorageModule } from './storage/storage.module';
import { MomentsModule } from './moments/moments.module';

@Module({
  imports: [
    ConfigureModule,
    PrismaModule.forRoot(),
    AuthModule.forRoot(),
    GraphQLModule,
    AccessTokenModule,
    UserModule,
    OneTimePasswordModule,
    StorageModule,
    MomentsModule,
  ],
})
export class AppModule {}
