import { Injectable } from '@nestjs/common';
import { Prisma, PrismaClient, ResourceCount } from '@prisma/client';
import { UtilHelpers } from 'src/helpers';

export enum UserCountType {
  following = 'user:following', // 关注的用户数量
  followers = 'user:followers', // 粉丝数量
  moments = 'user:moments', // 发布的动态数量
  likedMoments = 'user:liked-moments', // 喜欢的动态数量
  allMomentLikers = 'user:all-moment-likers', // 发布的动态喜欢总数
}

export enum MomentCountType {
  likers = 'moment:likers', // 喜欢的用户数量
  comments = 'moment:comments', // 评论数量
}

@Injectable()
export class ResourceCountService {
  constructor(private readonly prisma: PrismaClient) {}

  /**
   * 更新或者创建资源计数
   */
  upsert(
    type: UserCountType | MomentCountType,
    targetId: string,
    update: Prisma.IntFieldUpdateOperationsInput,
    create: number = 0,
  ): Prisma.Prisma__ResourceCountClient<ResourceCount> {
    return this.prisma.resourceCount.upsert({
      where: {
        type_targetId: {
          type,
          targetId,
        },
      },
      update: { count: update },
      create: {
        type,
        targetId,
        count: create,
      },
    });
  }

  /**
   * 获取资源计数
   */
  async get(
    type: UserCountType | MomentCountType,
    targetId: string,
    counter: () => Promise<number> = async () => 0,
  ): Promise<ResourceCount> {
    const count = await this.prisma.resourceCount.findUnique({
      where: {
        type_targetId: { type, targetId },
      },
      rejectOnNotFound: false,
    });

    if (UtilHelpers.isNotEmpty(count)) return count!;

    return this.prisma.resourceCount.create({
      data: {
        type,
        targetId,
        count: await counter(),
      },
    });
  }
}
