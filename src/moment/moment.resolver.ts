import { Parent, Query, ResolveField, Resolver } from '@nestjs/graphql';
import { PrismaClient } from '@prisma/client';
import { Moment } from './entities/moment.entity';

@Resolver(() => Moment)
export class MomentResolver {
  constructor(private readonly prisma: PrismaClient) {}

  @ResolveField()
  media(@Parent() { media }: Moment) {
    if (Array.isArray(media)) {
      return media;
    }

    return [media];
  }

  @ResolveField()
  user(@Parent() { userId }: Moment) {
    return this.prisma.user.findUnique({
      where: { id: userId },
    });
  }

  @Query(() => Moment)
  moment() {}
}
