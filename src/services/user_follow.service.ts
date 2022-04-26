import { Injectable } from '@nestjs/common';
import { FollowOnUser, PrismaClient, ResourceCount } from '@prisma/client';
import { UtilHelpers } from 'src/helpers';
import { ResourceCountService, UserCountType } from './resource_count.service';

@Injectable()
export class UserFollowService {
  constructor(
    private readonly prisma: PrismaClient,
    private readonly resourceCountService: ResourceCountService,
  ) {}

  /**
   * Follow
   */
  async follow(userId: string, targetId: string): Promise<ResourceCount> {
    const followed = await this.#followed(userId, targetId);

    if (UtilHelpers.isNotEmpty(followed)) {
      return this.followingCount(userId);
    }

    const [resource] = await this.prisma.$transaction([
      // Update or creater authencated user following count.
      this.resourceCountService.upsert(
        UserCountType.following,
        userId,
        { increment: 1 },
        1,
      ),

      // Update or creater target user followers count.
      this.resourceCountService.upsert(
        UserCountType.followers,
        targetId,
        { increment: 1 },
        1,
      ),

      // Create follow on user.
      this.prisma.followOnUser.create({
        data: {
          ownerId: userId,
          targetId,
        },
      }),
    ]);

    return resource;
  }

  /**
   * Unfollow
   */
  async unfollow(userId: string, targetId: string): Promise<ResourceCount> {
    const followed = await this.#followed(userId, targetId);

    if (UtilHelpers.isEmpty(followed)) {
      return this.followingCount(userId);
    }

    const [resource] = await this.prisma.$transaction([
      // Update or creater authencated user following count.
      this.resourceCountService.upsert(
        UserCountType.following,
        userId,
        { decrement: 1 },
        0,
      ),

      // Update or creater target user followers count.
      this.resourceCountService.upsert(
        UserCountType.followers,
        targetId,
        { decrement: 1 },
        0,
      ),

      // Delete follow on user.
      this.prisma.followOnUser.delete({
        where: {
          ownerId_targetId: { ownerId: userId, targetId },
        },
      }),
    ]);

    return resource;
  }

  /**
   * Get followd
   */
  #followed(userId: string, targetId: string): Promise<FollowOnUser | null> {
    return this.prisma.followOnUser.findUnique({
      where: {
        ownerId_targetId: {
          ownerId: userId,
          targetId,
        },
      },
      rejectOnNotFound: false,
    });
  }

  /**
   * Get following count
   */
  followingCount(userId: string): Promise<ResourceCount> {
    return this.resourceCountService.get(
      UserCountType.following,
      userId,
      (): Promise<number> =>
        this.prisma.followOnUser.count({
          where: { ownerId: userId },
        }),
    );
  }

  /**
   * Get followers count
   */
  followersCount(userId: string): Promise<ResourceCount> {
    return this.resourceCountService.get(
      UserCountType.followers,
      userId,
      (): Promise<number> =>
        this.prisma.followOnUser.count({
          where: { targetId: userId },
        }),
    );
  }
}
