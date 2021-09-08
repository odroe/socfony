import { Resolver, Query, Mutation, Args, Int, ResolveField, Parent } from '@nestjs/graphql';
import { UsersService } from './users.service';
import { CustomFields, User, UserInclude } from './entities/user.entity';
import { PrismaClient, User as PrismaUser } from '@prisma/client';
import { UserFindUniqueInput } from './dto/user-find-unique.input';

type NeedResolveFields = keyof CustomFields | keyof UserInclude;

type UsersResolveInterface = {
  [K in NeedResolveFields]: (...args: any[]) => User[K] | Promise<User[K]>;
};

@Resolver(() => User)
export class UsersResolver implements UsersResolveInterface {
  constructor(
    private readonly usersService: UsersService,
    private readonly prisma: PrismaClient,
  ) {}

  // TODO. Chack the user is viewer.
  @ResolveField()
  hasSetPassword(@Parent() { password }: PrismaUser) {
    return !!password;
  }

  @Query(() => User, { name: 'user' })
  findUnique(@Args('where', { type: () => UserFindUniqueInput }) where: UserFindUniqueInput) {
    return this.prisma.user.findUnique({
      where,
      rejectOnNotFound: true,
    });
  }
}
