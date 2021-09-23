import { PrismaClient, User, Prisma, UserProfile } from '@prisma/client';
import { Injectable } from '@nestjs/common';

@Injectable()
export class UserProfilesService {
  constructor(private readonly prisma: PrismaClient) {}

  async resolveProfile(user: string | User): Promise<UserProfile> {
    const userId = typeof user === 'string' ? user : user.id;
    const profile = await this.prisma.userProfile.findUnique({
      where: { userId },
      rejectOnNotFound: false,
    });

    if (!profile) {
      return this.prisma.userProfile.create({
        data: { userId },
      });
    }

    return profile;
  }
}
