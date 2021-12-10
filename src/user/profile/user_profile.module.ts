import { Module } from '@nestjs/common';
import { MediaModule } from 'media/media.module';
import { UserProfileResolver } from './user_profile.resolver';
import { UserProfileService } from './user_profile.service';

@Module({
  imports: [MediaModule],
  providers: [UserProfileService, UserProfileResolver],
  exports: [UserProfileService],
})
export class UserProfileModule {}
