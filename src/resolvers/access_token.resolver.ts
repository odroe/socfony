import { Parent, Query, ResolveField, Resolver } from '@nestjs/graphql';
import { AccessToken } from '@prisma/client';
import { AccessTokenEntity, UserEntity } from 'src/entities';
import { UserService } from 'src/services';

/**
 * Access token field resolver.
 */
@Resolver(() => AccessTokenEntity)
export class AccessTokenResolver {
  constructor(private readonly userService: UserService) {}

  /**
   * Resolve owner field.
   */
  @ResolveField('owner', () => UserEntity)
  resolveOwner(@Parent() { ownerId }: AccessToken) {
    return this.userService.findUniqueOrThrow({ id: ownerId });
  }
}
