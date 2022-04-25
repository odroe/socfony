// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { ApolloDriver, ApolloDriverConfig } from '@nestjs/apollo';
import { Module } from '@nestjs/common';
import { GraphQLModule as $GraphQLModule } from '@nestjs/graphql';
import { ApolloServerPluginLandingPageLocalDefault } from 'apollo-server-core';
import { AuthModule } from './auth';
import { ConfigureModule } from './configuration/configure.module';
import { PrismaModule } from './prisma';

const GraphQLModule = $GraphQLModule.forRootAsync<ApolloDriverConfig>({
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

@Module({
  imports: [
    ConfigureModule,
    GraphQLModule,
    PrismaModule,
    AuthModule,
  ],
})
export class AppModule {}
