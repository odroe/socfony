import { Injectable } from '@nestjs/common';
import { PrismaClient, User, UserProfile } from '@prisma/client';

@Injectable()
export class UserProfileService {
  constructor(private readonly prisma: PrismaClient) {}

  async resolve(user: User | string): Promise<UserProfile> {
    const userId = typeof user === 'string' ? user : user.id;
    const result = await this.prisma.userProfile.findUnique({
      where: { userId },
      rejectOnNotFound: false,
    });

    if (!result) {
      return this.prisma.userProfile.create({
        data: { userId },
      });
    }

    return result;
  }
}
