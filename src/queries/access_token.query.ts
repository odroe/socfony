import { Query, Resolver } from '@nestjs/graphql';
import { AccessToken } from '@prisma/client';
import { Auth } from 'src/auth';
import { AccessTokenEntity, UserEntity } from 'src/entities';
import { UserService } from 'src/services';

@Resolver(() => AccessTokenEntity)
export class AccessTokenQuery {
  constructor(private readonly userService: UserService) {}

  @Query(() => UserEntity, {
    nullable: false,
    name: 'authenticatedUser',
    description: 'Find the authenticated user.',
  })
  @Auth.must()
  async authenticatedUser(@Auth.accessToken() { ownerId }: AccessToken) {
    return this.userService.findUniqueOrThrow({ id: ownerId });
  }
}
