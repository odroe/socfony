import { Resolver, Query, Mutation, Args, Int, ResolveField, Parent } from '@nestjs/graphql';
import { UsersService } from './users.service';
import { CustomFields, User, UserInclude } from './entities/user.entity';
import { PrismaClient, User as PrismaUser } from '@prisma/client';
import { UserFindUniqueInput } from './dto/user-find-unique.input';

type NeedResolveKV = Pick<User, keyof CustomFields | keyof UserInclude>;

type UsersResolveInterface = {
  [K in keyof NeedResolveKV]: (...args: any[]) => NeedResolveKV[K] | Promise<NeedResolveKV[K]>;
};

@Resolver(() => User)
export class UsersResolver implements UsersResolveInterface {
  constructor(
    private readonly usersService: UsersService,
    private readonly prisma: PrismaClient,
  ) {}

  @ResolveField()
  hasSetPassword(@Parent() { password }: PrismaUser) {
    return !!password;
  }

  @Query(() => User, { name: 'user' })
  findUnique(@Args('where', { type: () => UserFindUniqueInput }) where: UserFindUniqueInput) {
    return this.prisma.user.findUnique({ where });
  }

  // TODO
  @Query(() => [User], { name: 'users' })
  findAll() {
    return this.usersService.findAll();
  }

  // TODO
  @Mutation(() => User)
  removeUser(@Args('id', { type: () => Int }) id: number) {
    return this.usersService.remove(id);
  }
}
