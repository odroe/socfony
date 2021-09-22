import { Resolver, Query, Args, ResolveField, Parent } from '@nestjs/graphql';
import { User, UserInclude } from './entities/user.entity';
import { PrismaClient, AccessToken } from '@prisma/client';
import { UserFindUniqueInput } from './dto/user-find-unique.input';
import { GetAccessToken } from 'src/auth/auth.decorator';

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

  @ResolveField()
  phone(
    @Parent() { phone, id }: User,
    @GetAccessToken() accessToklen: AccessToken,
  ) {
    if (id !== accessToklen?.userId || !phone) {
      return null;
    }

    return `${phone.substr(0, 3)} ${phone.substr(3, 1)}****${phone.substr(-3)}`;
  }

  @ResolveField()
  email(
    @Parent() { email, id }: User,
    @GetAccessToken() accessToklen: AccessToken,
  ) {
    if (!email || id !== accessToklen?.userId) {
      return null;
    }

    return `${email.substr(0, 1)}****${email.substr(email.indexOf('@'))}`;
  }
}
