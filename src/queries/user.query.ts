import { Args, Query, Resolver } from '@nestjs/graphql';
import { PrismaClient } from '@prisma/client';
import { UserEntity } from 'src/entities';
import { UserWhereInput } from 'src/inputs';

/**
 * User query.
 */
@Resolver(() => UserEntity)
export class UserQuery {
  constructor(private readonly prisma: PrismaClient) {}

  /**
   * Find one user.
   */
  @Query(() => UserEntity, {
    nullable: true,
    name: 'findOneUser',
    description: 'Find one user.',
  })
  async findOneUser(
    @Args('where', { type: () => UserWhereInput }) where: UserWhereInput,
  ) {
    return this.prisma.user.findFirst({
      where,
      rejectOnNotFound: false,
    });
  }
}
