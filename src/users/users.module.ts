import { Module } from '@nestjs/common';
import { UsersService } from './users.service';
import { UsersResolver } from './users.resolver';
import { UserProfilesModule } from './profiles/profiles.module';

@Module({
  imports: [UserProfilesModule],
  providers: [UsersResolver, UsersService],
})
export class UsersModule {}
