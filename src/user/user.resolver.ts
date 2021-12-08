import { PrismaClient } from '.prisma/client';
import {
  Args,
  ID,
  Mutation,
  Parent,
  Query,
  ResolveField,
  Resolver,
} from '@nestjs/graphql';
import { Auth } from 'shared/auth/auth.decorator';
import { User } from './entities/user.entity';

@Resolver(() => User)
export class UserResolver {
  constructor(private readonly prisma: PrismaClient) {}

  @Query(() => User)
  user(@Args('id', { type: () => ID }) id: string) {
    return this.prisma.user.findUnique({ where: { id } });
  }

  @Query(() => [User])
  users(@Args('in', { type: () => [ID] }) ids: string[]) {
    return this.prisma.user.findMany({
      where: {
        id: { in: ids },
      },
    });
  }

  @Mutation(() => User)
  @Auth()
  async updateUserAccountName(
    @Args('name', { type: () => String }) name: string,
    @Auth.user() user: User,
  ) {
    const exists = await this.prisma.user.findUnique({
      where: { name },
    });

    if (exists && exists.id !== user.id) {
      throw new Error('Name is already taken');
    }

    return this.prisma.user.update({
      where: { id: user.id },
      data: { name },
    });
  }

  @ResolveField(() => String)
  phone(@Parent() { phone }: User) {
    if (phone) {
      return '*'.repeat(phone.length - 2) + phone.substr(-2);
    }

    return null;
  }
}
