// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Module } from '@nestjs/common';
import { AccessTokenModule } from './access-token/access-token.module';
import { CommentModule } from './comment/comment.module';
import { ConfigureModule } from './configuration/configure_module';
import { GraphQLModule } from './graphql';
import { MomentModule } from './moment';
import { OneTimePasswordModule } from './one-time-password';
import { StorageModule } from './storage';
import { UserModule } from './user/user.module';

@Module({
  imports: [
    ConfigureModule,
    GraphQLModule,
    AccessTokenModule,
    UserModule,
    OneTimePasswordModule,
    StorageModule,
    MomentModule,
    CommentModule,
  ],
})
export class AppModule {}
