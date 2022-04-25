import { Parent, ResolveField, Resolver } from '@nestjs/graphql';
import { UserEntity, UserProfileEntity } from 'src/entities';
import { UserProfileService } from 'src/services';

@Resolver(() => UserEntity)
export class UserResolver {
  constructor(private readonly userProfileService: UserProfileService) {}

  /**
   * Resolve profile field.
   */
  @ResolveField('profile', () => UserProfileEntity)
  async resolveProfileField(@Parent() { id, profile }: UserEntity) {
    if (profile) return profile;

    return this.userProfileService.resolve(id);
  }
}
