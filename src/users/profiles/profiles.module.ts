import { Module } from '@nestjs/common';
import { UserProfilesResolver } from './profiles.resolver';
import { UserProfilesService } from './profiles.service';

@Module({
  providers: [UserProfilesService, UserProfilesResolver],
  exports: [UserProfilesService],
})
export class UserProfilesModule {}
