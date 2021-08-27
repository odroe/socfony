import { Module } from '@nestjs/common';
import { GraphQLModule } from '@nestjs/graphql';
import { PrismaModule } from '@socfony/prisma';
import { UsersModule } from './users/users.module';
import { AccessTokenModule } from './access-token/access-token.module';

@Module({
  imports: [
    PrismaModule.forRoot(),
    GraphQLModule.forRoot({
      autoSchemaFile: true,
      // playground: true,
      path: '/',
      sortSchema: true,
      fieldResolverEnhancers: ['guards'],
      buildSchemaOptions: {
        numberScalarMode: 'integer',
        dateScalarMode: 'isoDate',
      },
    }),
    AccessTokenModule,
    UsersModule,
  ],
})
export class AppModule {}
