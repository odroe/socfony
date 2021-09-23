import { Prisma, PrismaClient, User } from '@prisma/client';
import { Parent, ResolveField, Resolver } from '@nestjs/graphql';
import { UserProfile, UserProfileInclude } from './entities/profile.entity';

type UserProfilesResolverInterface = {
  [K in keyof UserProfileInclude]: (
    ...args: any[]
  ) => UserProfile[K] | Promise<UserProfile[K]>;
};

@Resolver(() => UserProfile)
export class UserProfilesResolver implements UserProfilesResolverInterface {
  constructor(private readonly prisma: PrismaClient) {}

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
}
