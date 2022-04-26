// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// Enums register.
import './enums.register';

import { ApolloDriver, ApolloDriverConfig } from '@nestjs/apollo';
import { GraphQLModule as $ } from '@nestjs/graphql';
import { ApolloServerPluginLandingPageLocalDefault } from 'apollo-server-core';

export const GraphQLModule = $.forRoot<ApolloDriverConfig>({
  driver: ApolloDriver,
  autoSchemaFile: true,
  playground: false,
  path: '/',
  sortSchema: true,
  plugins: [ApolloServerPluginLandingPageLocalDefault()],
  context: ({ req }) => req,
});

// export const GraphQLModule = $.forRootAsync<ApolloDriverConfig>({
//   driver: ApolloDriver,
//   useFactory: () => ({
//     autoSchemaFile: true,
//     playground: false,
//     path: '/',
//     sortSchema: true,
//     plugins: [ApolloServerPluginLandingPageLocalDefault()],
//     context: ({ req }) => req,
//     autoTransformHttpErrors: true,
//     include: [GraphQLBindingModule],
//   }),
// });
