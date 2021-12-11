// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { GraphQLModule } from '@nestjs/graphql';
import { ApolloServerPluginLandingPageLocalDefault } from 'apollo-server-core';

export const GraphQL = GraphQLModule.forRoot({
  autoSchemaFile: true,
  installSubscriptionHandlers: false,
  playground: false,
  plugins: [ApolloServerPluginLandingPageLocalDefault()],
  path: '/',
  buildSchemaOptions: {
    dateScalarMode: 'isoDate',
  },
  context: ({ req }) => req,
});
