import { Module } from '@nestjs/common';
import { AccessTokenModule } from 'access_token/access_token.module';
import { SharedModule } from 'shared/shared.module';
import { UserModule } from 'user/user.module';
import { VerificationCodeModule } from 'verification_code/verification_code.module';
import { GraphQL } from './graphql/graphql.module';

@Module({
  imports: [
    SharedModule,
    GraphQL,
    AccessTokenModule,
    VerificationCodeModule,
    UserModule,
  ],
})
export class AppModule {}
