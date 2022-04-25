// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Module } from '@nestjs/common';

import { AuthModule } from './auth';
import { ConfigureModule } from './configuration';
import { GraphQLModule } from './graphql.module';
import { PrismaModule } from './prisma';
import * as mutations from './mutations';
import * as services from './services';

@Module({
  imports: [ConfigureModule, GraphQLModule, PrismaModule, AuthModule],
  providers: [...Object.values(mutations), ...Object.values(services)],
})
export class AppModule {}
