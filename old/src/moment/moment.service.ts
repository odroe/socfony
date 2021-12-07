import { Injectable } from '@nestjs/common';
import { PrismaClient } from '@prisma/client';

@Injectable()
export class MomentService {
  constructor(private readonly prisma: PrismaClient) {}

  public async hasLiked(momentId: string, userId?: string) {
    if (!userId) {
      return false;
    }

    const row = await this.prisma.userLikeOnMoment.findUnique({
      where: {
        userId_momentId: { userId, momentId },
      },
      rejectOnNotFound: false,
    });

    return !!row;
  }
}
