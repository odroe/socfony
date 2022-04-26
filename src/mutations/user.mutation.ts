import { Args, Mutation, Resolver } from '@nestjs/graphql';
import { AccessToken, PrismaClient } from '@prisma/client';
import { Auth } from 'src/auth';
import { UserEntity } from 'src/entities';
import { ERROR_CODE_USER_USERNAME_ALREADY_EXISTS } from 'src/errorcodes';
import { GraphQLException } from 'src/graphql.exception';

@Resolver(() => UserEntity)
export class UserMutation {
  constructor(private readonly prisma: PrismaClient) {}

  /**
   * Update authencated user username.
   */
  @Mutation(() => UserEntity, {
    description: 'Update authencated user username.',
  })
  @Auth.must()
  async updateUseranme(
    @Auth.accessToken() { ownerId }: AccessToken,
    @Args('username', { type: () => String }) username: string,
  ) {
    const exists = await this.prisma.user.findUnique({
      where: { username },
      rejectOnNotFound: false,
    });
    if (exists && exists.id !== ownerId) {
      throw new GraphQLException(ERROR_CODE_USER_USERNAME_ALREADY_EXISTS);
    }

    return this.prisma.user.update({
      where: { id: ownerId },
      data: { username },
    });
  }
}
