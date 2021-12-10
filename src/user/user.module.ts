import { Module } from '@nestjs/common';
import { VerificationCodeModule } from 'verification_code/verification_code.module';
import { UserResolver } from './user.resolver';

@Module({
  imports: [VerificationCodeModule],
  providers: [UserResolver],
})
export class UserModule {}
