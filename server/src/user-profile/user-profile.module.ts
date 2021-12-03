import { Module } from '@nestjs/common';
import { AccessTokenModule } from 'src/access-token/access-token.module';
import { PrismaModule } from 'src/shared';
import { StorageModule } from 'src/storage/storage.module';
import { UserProfileMutation } from './user-profile.mutation';
import { UserProfileQuery } from './user-profile.query';
import { UserProfileService } from './user-profile.service';

@Module({
  imports: [PrismaModule, AccessTokenModule, StorageModule],
  controllers: [UserProfileQuery, UserProfileMutation],
  providers: [UserProfileService],
  exports: [UserProfileService],
})
export class UserProfileModule {}
