import { Query, Resolver } from '@nestjs/graphql';
import { AccessToken, User } from '@prisma/client';
import { Auth } from 'src/auth';
import { UserSecurityEntity } from 'src/entities';
import { UserService } from 'src/services';

@Resolver(() => UserSecurityEntity)
export class UserSecurityQuery {
  constructor(private readonly userService: UserService) {}

  /**
   * Query authenticated user security.
   */
  @Query(() => UserSecurityEntity, {
    nullable: true,
    description: 'Query authenticated user security.',
    name: 'authenticatedUserSecurity',
  })
  @Auth.must()
  queryAuthenticatedUserSecurity(
    @Auth.accessToken() { ownerId }: AccessToken,
  ): Promise<User> {
    return this.userService.findUniqueOrThrow({ id: ownerId });
  }
}
