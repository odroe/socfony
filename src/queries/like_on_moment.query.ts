import { Args, Query, Resolver } from '@nestjs/graphql';
import { PrismaClient } from '@prisma/client';
import { LikeOnMomentFindManyArgs } from 'src/args';
import { LikeOnMomentEntity } from 'src/entities';

@Resolver(() => LikeOnMomentEntity)
export class LikeOnMomentQuery {
  constructor(private readonly prisma: PrismaClient) {}

  /**
   * Query like on moment many.
   */
  @Query(() => [LikeOnMomentEntity], {
    nullable: false,
    description: 'Query like on moment many.',
    name: 'likeOnMomentList',
  })
  async queryLikeOnMomentList(
    @Args({ type: () => LikeOnMomentFindManyArgs })
    args: LikeOnMomentFindManyArgs,
  ) {
    return this.prisma.likeOnMoment.findMany({
      ...args,
      orderBy: { createdAt: 'desc' },
    });
  }
}
