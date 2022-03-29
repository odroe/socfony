// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { ApolloDriver, ApolloDriverConfig } from '@nestjs/apollo';
import { ConfigType } from '@nestjs/config';
import { GraphQLModule as $ } from '@nestjs/graphql';
import { ApolloServerPluginLandingPageLocalDefault } from 'apollo-server-core';
import graphql from 'src/configuration/graphql';

import './enums.register';

export const GraphQLModule = $.forRootAsync<ApolloDriverConfig>({
  inject: [graphql.KEY],
  driver: ApolloDriver,
  useFactory: ({ path }: ConfigType<typeof graphql>) => ({
    autoSchemaFile: true,
    playground: false,
    path,
    sortSchema: true,
    plugins: [ApolloServerPluginLandingPageLocalDefault()],
    context: ({ req }) => req,
  }),
});
