// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Module, Provider } from '@nestjs/common';

import { AuthModule } from './auth';
import { ConfigureModule } from './configuration';
import { GraphQLModule } from './graphql.module';
import { PrismaModule } from './prisma';

import * as mutations from './mutations';
import * as queries from './queries';
import * as resolvers from './resolvers';
import * as services from './services';

function filter(providers: Record<string, any>, endsWith: string): Provider[] {
  const filtered: Provider[] = [];
  for (const key in providers) {
    if (key.endsWith(endsWith)) {
      filtered.push(providers[key]);
    }
  }

  return filtered;
}

@Module({
  imports: [ConfigureModule, GraphQLModule, PrismaModule, AuthModule],
  providers: [
    ...filter(mutations, 'Mutation'),
    ...filter(queries, 'Query'),
    ...filter(resolvers, 'Resolver'),
    ...filter(services, 'Service'),
  ],
})
export class AppModule {}
