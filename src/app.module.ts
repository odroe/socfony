import { Module } from '@nestjs/common';
import { GraphQLModule } from '@nestjs/graphql';
import { ApolloServerPluginLandingPageLocalDefault } from 'apollo-server-core';
import { UsersModule } from './users/users.module';

@Module({
  imports: [
    GraphQLModule.forRoot({
      autoSchemaFile: true,
      installSubscriptionHandlers: false,
      playground: false,
      plugins: [
        ApolloServerPluginLandingPageLocalDefault(),
      ],
      path: '/',
    }),
    UsersModule,
  ],
})
export class AppModule {}
