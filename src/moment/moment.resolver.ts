import { Args, ID, Query, Resolver } from '@nestjs/graphql';
import {
  Prisma,
  PrismaClient,
  Moment as _Moment,
  User as _User,
  Comment as _Comment,
  PrismaPromise,
} from '@prisma/client';

import { MomentFindManyArgs } from './dto/moment-find-many.args';
import { Moment } from './entities/moment.entity';

@Resolver(() => Moment)
export class MomentResolver {
  constructor(private readonly prisma: PrismaClient) {}

  @Query(() => Moment, { nullable: true, description: 'Find a moment.' })
  moment(
    @Args({ name: 'id', type: () => ID, description: 'Moment ID.' }) id: string,
  ): Prisma.Prisma__MomentClient<_Moment | null> {
    return this.prisma.moment.findUnique({
      where: { id },
      rejectOnNotFound: false,
    });
  }

  @Query(() => [Moment], { description: 'Find moments.', nullable: 'items' })
  moments(
    @Args({ type: () => MomentFindManyArgs }) args: MomentFindManyArgs,
  ): PrismaPromise<_Moment[]> {
    return this.prisma.moment.findMany(args);
  }
}
