import { Parent, ResolveField, Resolver } from '@nestjs/graphql';
import { Media } from 'media/entities/media.entity';
import { UserProfile } from './entities/user_profile.entity';

@Resolver(() => UserProfile)
export class UserProfileResolver {
  constructor() {}

  @ResolveField(() => Media, { nullable: true })
  avatar(@Parent() { avatar }: UserProfile) {
    if (avatar) {
      return new Media(avatar);
    }

    return avatar;
  }
}
