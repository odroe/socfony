import { Module } from '@nestjs/common';
import { VerificationCodeModule } from 'verification_code/verification_code.module';
import { UserProfileModule } from './profile/user_profile.module';
import { UserResolver } from './user.resolver';

@Module({
  imports: [VerificationCodeModule, UserProfileModule],
  providers: [UserResolver],
})
export class UserModule {}
