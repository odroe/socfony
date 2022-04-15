// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Module } from '@nestjs/common';
import { ClientRestApiModule } from './client-rest-api/client-rest-api.module';
import { ConfigureModule } from './configuration/configure_module';
import { GraphQLModule } from './graphql';

@Module({
  imports: [ConfigureModule, GraphQLModule, ClientRestApiModule],
})
export class AppModule {}
