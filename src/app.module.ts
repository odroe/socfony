// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Module } from '@nestjs/common';
import { AccessTokenModule } from './access-token/access-token.module';
import { GraphQLModule } from './graphql';
import { OneTimePasswordModule } from './one-time-password';
import { UserModule } from './user/user.module';

@Module({
  imports: [
    GraphQLModule,
    AccessTokenModule,
    UserModule,
    OneTimePasswordModule,
  ],
})
export class AppModule {}
