// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { ApolloDriver, ApolloDriverConfig } from '@nestjs/apollo';
import { GraphQLModule as $ } from '@nestjs/graphql';
import { ApolloServerPluginLandingPageLocalDefault } from 'apollo-server-core';

import './enums.register';

export const GraphQLModule = $.forRootAsync<ApolloDriverConfig>({
  driver: ApolloDriver,
  useFactory: () => ({
    autoSchemaFile: true,
    playground: false,
    path: '/graphql',
    sortSchema: true,
    plugins: [ApolloServerPluginLandingPageLocalDefault()],
    context: ({ req }) => req,
  }),
});
