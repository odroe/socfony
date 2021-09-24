import { Module } from '@nestjs/common';
import { AccessTokenModule } from './access-token/access-token.module';
import { PrismaModule } from './prisma';
import { UsersModule } from './users/users.module';
import { VerificationCodeModule } from './verification-code/verification-code.module';
import { AuthModule } from './auth/auth.module';
import { MediaModule } from './media/media.module';
import { GraphQLModule } from './graphql';

@Module({
  imports: [
    GraphQLModule,
    AuthModule,
    PrismaModule,
    AccessTokenModule,
    UsersModule,
    VerificationCodeModule,
    MediaModule,
  ],
})
export class AppModule {}
