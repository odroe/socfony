import { Module } from '@nestjs/common';
import { UsersResolver } from './users.resolver';
import { UserProfilesModule } from './profiles/profiles.module';

@Module({
  imports: [UserProfilesModule],
  providers: [UsersResolver],
})
export class UsersModule {}
