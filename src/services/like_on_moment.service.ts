import { Injectable } from '@nestjs/common';
import { LikeOnMoment, PrismaClient } from '@prisma/client';
import { UtilHelpers } from 'src/helpers';
import {
  MomentCountType,
  ResourceCountService,
  UserCountType,
} from './resource_count.service';

@Injectable()
export class LikeOnMomentService {
  constructor(
    private readonly prisma: PrismaClient,
    private readonly resourceCountService: ResourceCountService,
  ) {}

  /**
   * Like a moment.
   */
  async like(userId: string, momentId: string): Promise<LikeOnMoment> {
    const like = await this.liked(userId, momentId);

    // If like exists, return it.
    if (UtilHelpers.isNotEmpty(like)) return like!;

    const moment = await this.prisma.moment.findUnique({
      where: { id: momentId },
      rejectOnNotFound: true,
    });

    const [resource] = await this.prisma.$transaction([
      // Create like on moment.
      this.prisma.likeOnMoment.create({
        data: {
          userId,
          momentId,
        },
      }),

      /// Update or create moment likers count.
      this.resourceCountService.upsert(
        MomentCountType.likers,
        momentId,
        { increment: 1 },
        1,
      ),

      // Update or create user liked moments count.
      this.resourceCountService.upsert(
        UserCountType.likedMoments,
        userId,
        { increment: 1 },
        1,
      ),

      // Update or create user all moment likes count.
      this.resourceCountService.upsert(
        UserCountType.allMomentLikers,
        moment.publisherId,
        { increment: 1 },
        1,
      ),
    ]);

    return resource;
  }

  /**
   * Unlike a moment.
   */
  async unlike(userId: string, momentId: string): Promise<void> {
    const like = await this.liked(userId, momentId);

    // If like exists, delete it.
    if (UtilHelpers.isNotEmpty(like)) {
      await this.prisma.$transaction([
        // Delete like on moment.
        this.prisma.likeOnMoment.delete({
          where: {
            userId_momentId: { userId, momentId },
          },
        }),

        /// Update or create moment likers count.
        this.resourceCountService.upsert(
          MomentCountType.likers,
          momentId,
          { decrement: 1 },
          0,
        ),

        // Update or create user liked moments count.
        this.resourceCountService.upsert(
          UserCountType.likedMoments,
          userId,
          { decrement: 1 },
          0,
        ),

        // Update or create user all moment likes count.
        this.resourceCountService.upsert(
          UserCountType.allMomentLikers,
          like!.moment.publisherId,
          { decrement: 1 },
          0,
        ),
      ]);
    }
  }

  /**
   * Check if user liked a moment.
   */
  liked(userId: string, momentId: string) {
    return this.prisma.likeOnMoment.findUnique({
      where: {
        userId_momentId: { userId, momentId },
      },
      include: { moment: true },
      rejectOnNotFound: false,
    });
  }

  /**
   * Get all likers count of a moment.
   */
  async momentLikersCount(momentId: string): Promise<number> {
    const { count } = await this.resourceCountService.get(
      MomentCountType.likers,
      momentId,
      () => this.prisma.likeOnMoment.count({ where: { momentId } }),
    );

    return count;
  }

  /**
   * Get all liked moments count of a user.
   */
  async userLikedMomentsCount(userId: string): Promise<number> {
    const { count } = await this.resourceCountService.get(
      UserCountType.likedMoments,
      userId,
      () => this.prisma.likeOnMoment.count({ where: { userId } }),
    );

    return count;
  }

  /**
   * Get user all published moment likers count.
   */
  async userAllMomentLikersCount(userId: string): Promise<number> {
    const { count } = await this.resourceCountService.get(
      UserCountType.allMomentLikers,
      userId,
      async (): Promise<number> =>
        this.prisma.likeOnMoment.count({
          where: {
            moment: { publisherId: userId },
          },
        }),
    );

    return count;
  }
}
