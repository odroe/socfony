import { GraphQLModule } from '@nestjs/graphql';
import { ApolloServerPluginLandingPageLocalDefault } from 'apollo-server-core';

export const GraphQL = GraphQLModule.forRoot({
  autoSchemaFile: true,
  installSubscriptionHandlers: false,
  playground: false,
  plugins: [
    ApolloServerPluginLandingPageLocalDefault(),
  ],
  path: '/',
  buildSchemaOptions: {
    dateScalarMode: 'isoDate',
  },
  context: ({ req }) => req,
});