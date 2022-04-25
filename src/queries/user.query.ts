import { Args, Query, Resolver } from '@nestjs/graphql';
import { PrismaClient } from '@prisma/client';
import { UserFindManyArgs } from 'src/args';
import { UserEntity } from 'src/entities';
import { UtilHelpers } from 'src/helpers';
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
    name: 'userFindOne',
    description: 'Find one user.',
  })
  async findOne(
    @Args('where', { type: () => UserWhereInput }) where: UserWhereInput,
  ) {
    if (UtilHelpers.isEmpty(where)) {
      return null;
    }

    return this.prisma.user.findFirst({
      where,
      rejectOnNotFound: false,
    });
  }

  /**
   * Find many users.
   */
  @Query(() => [UserEntity], {
    nullable: false,
    name: 'userFindMany',
    description: 'Find many user.',
  })
  async findMany(
    @Args({ type: () => UserFindManyArgs }) args: UserFindManyArgs,
  ) {
    return this.prisma.user.findMany(args);
  }
}
