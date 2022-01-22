import { Args, Query, Resolver } from '@nestjs/graphql';
import { PrismaClient } from '@prisma/client';
import { UserWhereUniqueInput } from './dto/user-where-unique.input';
import { User } from './entities/user.entity';
import { UserService } from './user.service';

@Resolver(() => User)
export class UserResolver {
  constructor(
    private readonly userService: UserService,
    private readonly prisma: PrismaClient,
  ) {}

  @Query(() => User, {
    description: 'Find a user by unique where',
    nullable: true,
  })
  async userFindUnique(
    @Args({ name: 'where', type: () => UserWhereUniqueInput })
    where: UserWhereUniqueInput,
  ) {
    return this.prisma.user.findUnique({ where, rejectOnNotFound: false });
  }
}
