import { Args, Query, Resolver } from '@nestjs/graphql';
import { PrismaClient } from '@prisma/client';
import { FollowOnUserFindManyArgs } from 'src/args';
import { FollowOnUserEntity } from 'src/entities';

@Resolver(() => FollowOnUserEntity)
export class FollowOnUserQuery {
  constructor(private readonly prisma: PrismaClient) {}

  /**
   * query for follow on users
   */
  @Query(() => [FollowOnUserEntity], {
    name: 'followOnUserList',
    description: 'query for follow on users',
    nullable: false,
  })
  async queryFollowOnUserList(
    @Args({ type: () => FollowOnUserFindManyArgs })
    args: FollowOnUserFindManyArgs,
  ) {
    return this.prisma.followOnUser.findMany({
      ...args,
      orderBy: { createdAt: 'desc' },
    });
  }
}
