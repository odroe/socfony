import { Prisma, PrismaClient, User } from '@prisma/client';
import { Args, Mutation, Parent, ResolveField, Resolver } from '@nestjs/graphql';
import { UserProfile, UserProfileInclude } from './entities/profile.entity';
import { UserProfileUpdateInput } from './dto/user-profile-update.input';
import { UserProfilesService } from './profiles.service';
import { Auth, GetUser } from 'src/auth/auth.decorator';

type UserProfilesResolverInterface = {
  [K in keyof UserProfileInclude]: (
    ...args: any[]
  ) => UserProfile[K] | Promise<UserProfile[K]>;
};

@Resolver(() => UserProfile)
export class UserProfilesResolver implements UserProfilesResolverInterface {
  constructor(
    private readonly prisma: PrismaClient,
    private readonly userProfilesService: UserProfilesService,
  ) {}

  @ResolveField()
  async user(
    @Parent()
    {
      user,
      userId,
    }: Prisma.UserProfileGetPayload<{ include: UserProfileInclude }>,
  ): Promise<User> {
    if (user) {
      return user;
    }

    return this.prisma.user.findUnique({
      where: { id: userId },
      rejectOnNotFound: false,
    });
  }

  @ResolveField()
  avatar(@Parent() { avatar }: UserProfile) {
    if (avatar) {
      return { resource: avatar };
    }

    return null;
  }

  @Auth()
  @Mutation(() => UserProfile, { description: 'Update user profile' })
  async updateUserProfile(
    @GetUser() user: User,
    @Args('data') data: UserProfileUpdateInput,
  ) {
    return this.userProfilesService.updateUserProfile(user, data);
  }
}
