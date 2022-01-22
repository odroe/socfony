import { GraphQLModule as $ } from '@nestjs/graphql';
import { ApolloServerPluginLandingPageLocalDefault } from 'apollo-server-core';

export const GraphQLModule = $.forRoot({
  autoSchemaFile: true,
  playground: false,
  path: '/graphql',
  plugins: [ApolloServerPluginLandingPageLocalDefault()],
});
