import { Parent, ResolveField, Resolver } from '@nestjs/graphql';
import { FollowOnUserEntity, UserEntity } from 'src/entities';
import { UtilHelpers } from 'src/helpers';
import { UserService } from 'src/services';

@Resolver(() => FollowOnUserEntity)
export class FollowOnUserResolver {
  constructor(private readonly userService: UserService) {}

  /**
   * Resolve owner field
   */
  @ResolveField('owner', () => UserEntity)
  resolveOwnerField(@Parent() parent: FollowOnUserEntity) {
    if (UtilHelpers.isNotEmpty(parent.owner)) return parent.owner;

    return this.userService.findUniqueOrThrow({
      id: parent.ownerId,
    });
  }

  /**
   * Resolve target field
   */
  @ResolveField('target', () => UserEntity)
  resolveTargetField(@Parent() parent: FollowOnUserEntity) {
    if (UtilHelpers.isNotEmpty(parent.target)) return parent.target;

    return this.userService.findUniqueOrThrow({
      id: parent.targetId,
    });
  }
}
