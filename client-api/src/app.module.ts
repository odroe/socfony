import { Module } from '@nestjs/common';
import { GraphQLModule } from '@nestjs/graphql';
import { UsersModule } from './users/users.module';

@Module({
  imports: [
    GraphQLModule.forRoot({
      path: '/',
      playground: true,
    }),
    UsersModule,
  ],
})
export class AppModule {}
