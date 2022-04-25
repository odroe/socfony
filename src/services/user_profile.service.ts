import { Injectable } from '@nestjs/common';
import { PrismaClient, User, UserProfile } from '@prisma/client';

@Injectable()
export class UserProfileService {
  constructor(private readonly prisma: PrismaClient) {}

  /**
   * Resolve user profile, if profile is not found, create it.
   *
   * @param user Need resolve profile owner.
   * @returns {UserProfile}
   */
  async resolve(user: User | string): Promise<UserProfile> {
    const profile = await this.prisma.userProfile.findUnique({
      where: { ownerId: typeof user === 'string' ? user : user.id },
      rejectOnNotFound: false,
    });
    if (profile) return profile;

    return this.prisma.userProfile.create({
      data: {
        ownerId: typeof user === 'string' ? user : user.id,
      },
    });
  }
}
