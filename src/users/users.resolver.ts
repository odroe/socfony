import { Args, Parent, Query, ResolveField, Resolver } from '@nestjs/graphql';
import { User, UserInclude } from './entities/user.entity';
import {
  AccessToken,
  PrismaClient,
  User as UserInterface,
} from '@prisma/client';
import { UserWhereUniqueInput } from './dto/user-where-unique.input';
import { GetAccessToken } from 'src/auth/auth.decorator';
import { UserProfilesService } from './profiles/profiles.service';
import { UserFindManyArgs } from './dto/user-find-many.args';

type UsersResolverInterface = {
  [K in keyof UserInclude]: (...args: any[]) => User[K] | Promise<User[K]>;
};

@Resolver(() => User)
export class UsersResolver implements UsersResolverInterface {
  constructor(
    private readonly prisma: PrismaClient,
    private readonly profileService: UserProfilesService,
  ) {}

  @Query(() => User, { name: 'user', description: 'Using unique find a user.' })
  findUnique(
    @Args('where', { type: () => UserWhereUniqueInput })
    where: UserWhereUniqueInput,
  ) {
    return this.prisma.user.findUnique({
      where,
      rejectOnNotFound: true,
    });
  }

  @Query(() => [User], {
    name: 'users',
    description: 'Find many users.',
    nullable: true,
  })
  findMany(
    @Args({ type: () => UserFindManyArgs })
    args: UserFindManyArgs,
  ) {
    return this.prisma.user.findMany(args);
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

  @ResolveField()
  profile(@Parent() user: UserInterface) {
    return this.profileService.resolveProfile(user);
  }
}
