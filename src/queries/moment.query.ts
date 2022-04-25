import { Args, Query, Resolver } from '@nestjs/graphql';
import { PrismaClient } from '@prisma/client';
import { MomentEntity } from 'src/entities';
import { UtilHelpers } from 'src/helpers';
import { MomentWhereInput } from 'src/inputs';

@Resolver(() => MomentEntity)
export class MomentQuery {
  constructor(private readonly prisma: PrismaClient) {}

  /**
   * Moment find one.
   */
  @Query(() => MomentEntity, {
    name: 'momentFindOne',
    nullable: true,
    description: 'Find one moment.',
  })
  async findOne(
    @Args('where', { type: () => MomentWhereInput }) where: MomentWhereInput,
  ) {
    if (UtilHelpers.isEmpty(where)) {
      return null;
    }

    return this.prisma.moment.findFirst({
      where,
      rejectOnNotFound: false,
      include: { storages: true },
    });
  }
}
