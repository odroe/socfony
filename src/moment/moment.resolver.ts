import {
  Args,
  ID,
  Parent,
  Query,
  ResolveField,
  Resolver,
} from '@nestjs/graphql';
import {
  Prisma,
  PrismaClient,
  Moment as _Moment,
  User as _User,
  PrismaPromise,
} from '@prisma/client';
import { User } from 'src/user/entities/user.entity';
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

  @ResolveField(() => User)
  user(
    @Parent()
    { userId, user }: Prisma.MomentGetPayload<{ include: { user: true } }>,
  ): Prisma.Prisma__UserClient<_User> | Promise<_User> {
    if (user) return Promise.resolve<_User>(user);

    return this.prisma.user.findUnique({
      where: { id: userId },
      rejectOnNotFound: true,
    });
  }
}
