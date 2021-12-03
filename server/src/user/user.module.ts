import { Module } from '@nestjs/common';
import { AccessTokenModule } from 'src/access-token/access-token.module';
import { PrismaModule } from 'src/shared';
import { StorageModule } from 'src/storage/storage.module';
import { VerificationCodeModule } from 'src/verification-code/verification-code.module';
import { UserMutation } from './user.mutation';
import { UserQuery } from './user.query';
import { UserService } from './user.service';

@Module({
  imports: [
    PrismaModule,
    AccessTokenModule,
    VerificationCodeModule,
    StorageModule,
  ],
  controllers: [UserQuery, UserMutation],
  providers: [UserService],
  exports: [UserService],
})
export class UserModule {}
