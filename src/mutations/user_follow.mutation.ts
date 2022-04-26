import { Args, Int, Mutation, Resolver } from '@nestjs/graphql';
import { AccessToken } from '@prisma/client';
import { Auth } from 'src/auth';
import { FollowOnUserEntity } from 'src/entities';
import { UserFollowService, UserService } from 'src/services';

@Resolver(() => FollowOnUserEntity)
export class UserFollowMutation {
  constructor(
    private readonly userService: UserService,
    private readonly userFollowService: UserFollowService,
  ) {}

  /**
   * Follow a user
   */
  @Mutation(() => Int, {
    name: 'followUser',
    description: 'Follow a user',
    nullable: false,
  })
  @Auth.must()
  async follow(
    @Auth.accessToken() { ownerId }: AccessToken,
    @Args('id', {
      nullable: false,
      type: () => String,
      description: 'User ID to follow',
    })
    targetId: string,
  ) {
    // Validate target user is exist.
    await this.userService.findUniqueOrThrow({ id: targetId });

    // Run follow and get following count.
    const { count } = await this.userFollowService.follow(ownerId, targetId);

    return count;
  }

  /**
   * Unfollow a user
   */
  @Mutation(() => Int, {
    name: 'unfollowUser',
    description: 'Unfollow a user',
    nullable: false,
  })
  @Auth.must()
  async unfollow(
    @Auth.accessToken() { ownerId }: AccessToken,
    @Args('id', {
      nullable: false,
      type: () => String,
      description: 'User ID to unfollow',
    })
    targetId: string,
  ) {
    // Validate target user is exist.
    await this.userService.findUniqueOrThrow({ id: targetId });

    // Run unfollow and get following count.
    const { count } = await this.userFollowService.unfollow(ownerId, targetId);

    return count;
  }
}
