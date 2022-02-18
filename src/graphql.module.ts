// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { ApolloDriver, ApolloDriverConfig } from '@nestjs/apollo';
import { GraphQLModule as $ } from '@nestjs/graphql';
import { ApolloServerPluginLandingPageLocalDefault } from 'apollo-server-core';

export const GraphQLModule = $.forRoot<ApolloDriverConfig>({
  driver: ApolloDriver,
  autoSchemaFile: true,
  playground: false,
  path: '/graphql',
  sortSchema: true,
  plugins: [ApolloServerPluginLandingPageLocalDefault()],
});
