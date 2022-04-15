// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { ApolloDriver, ApolloDriverConfig } from '@nestjs/apollo';
import { ConfigType } from '@nestjs/config';
import { GraphQLModule as $ } from '@nestjs/graphql';
import { ApolloServerPluginLandingPageLocalDefault } from 'apollo-server-core';
import { AccessTokenModule } from 'src/graphql/access-token/access-token.module';
import graphql from 'src/configuration/graphql';
import { OneTimePasswordModule } from 'src/graphql/one-time-password';
import { StorageModule } from 'src/graphql/storage';
import { UserModule } from 'src/graphql/user/user.module';

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
  imports: [
    AccessTokenModule,
    UserModule,
    OneTimePasswordModule,
    StorageModule,
  ],
});
