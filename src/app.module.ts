import { Module } from '@nestjs/common';
import { GraphQLModule } from '@nestjs/graphql';
import { AccessTokenModule } from './access-token/access-token.module';
import { PrismaModule } from './prisma';
import { UsersModule } from './users/users.module';
import { VerificationCodeModule } from './verification-code/verification-code.module';

@Module({
  imports: [
    GraphQLModule.forRoot({
      autoSchemaFile: true,
      path: '/',
      sortSchema: true,
      fieldResolverEnhancers: ['guards'],
      buildSchemaOptions: {
        numberScalarMode: 'integer',
        dateScalarMode: 'isoDate',
      },
    }),
    PrismaModule.forRoot(),
    AccessTokenModule,
    UsersModule,
    VerificationCodeModule,
  ],
})
export class AppModule {}
