import { Resolver, Query, Args } from '@nestjs/graphql';
import { User, UserInclude } from './entities/user.entity';
import { PrismaClient } from '@prisma/client';
import { UserFindUniqueInput } from './dto/user-find-unique.input';

type UsersResolveInterface = {
  [K in keyof UserInclude]: (...args: any[]) => User[K] | Promise<User[K]>;
};

@Resolver(() => User)
export class UsersResolver implements UsersResolveInterface {
  constructor(private readonly prisma: PrismaClient) {}

  @Query(() => User, { name: 'user' })
  findUnique(
    @Args('where', { type: () => UserFindUniqueInput })
    where: UserFindUniqueInput,
  ) {
    return this.prisma.user.findUnique({
      where,
      rejectOnNotFound: true,
    });
  }
}
