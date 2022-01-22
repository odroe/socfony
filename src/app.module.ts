import { Module } from '@nestjs/common';
import { AccessTokenModule } from './access-token/access-token.module';
import { GraphQLModule } from './graphql.module';
import { UserModule } from './user/user.module';

@Module({
  imports: [GraphQLModule, AccessTokenModule, UserModule],
})
export class AppModule {}
