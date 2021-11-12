import { Module } from '@nestjs/common';
import { PrismaModule } from 'src/shared';
import { UserProfileQuery } from './user-profile.query';
import { UserProfileService } from './user-profile.service';

@Module({
  imports: [PrismaModule],
  controllers: [UserProfileQuery],
  providers: [UserProfileService],
  exports: [UserProfileService],
})
export class UserProfileModule {}
