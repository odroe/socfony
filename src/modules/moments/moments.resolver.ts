import {
  Resolver,
  Query,
  Mutation,
  Args,
  Int,
  ResolveField,
  Parent,
} from '@nestjs/graphql';

import { Moment } from './entities/moment.entity';
import { CreateMomentInput } from './dto/create-moment.input';
import {
  AccessToken,
  Prisma,
  PrismaClient,
  Moment as MomentInterface,
} from '@prisma/client';
import { Auth } from 'src/auth';
import { Helper, ID } from 'src/utils';

@Resolver(() => Moment)
export class MomentsResolver {
  constructor(private readonly prisma: PrismaClient) {}

  /**
   * Create a moment.
   * @returns {Promise<MomentInterface>}
   */
  @Mutation(() => Moment)
  @Auth.must()
  async createMoment(
    @Args('createMomentInput') { title, content, storages }: CreateMomentInput,
    @Auth.accessToken() { userId }: AccessToken,
  ): Promise<MomentInterface> {
    if (
      Helper.isEmpty(title) &&
      Helper.isEmpty(content) &&
      Helper.isEmpty(storages)
    ) {
      throw new Error('Moment must have at least one field.');
    }


    if (Helper.isNotEmpty(storages)) {
      const storageOnMoment: Prisma.StorageOnMomentUncheckedCreateNestedManyWithoutMomentInput = {
        createMany: {
          skipDuplicates: true,
          data: Object.values(storages!).map((storageId) => ({ storageId })),
        },
      };

      const [moment] = await this.prisma.$transaction([
        /// Create moment
        this.prisma.moment.create({
          data: {
            id: ID.primary(),
            userId,
            title,
            content,
            storages: storageOnMoment,
          },
        }),
        /// Update storage is used
        this.prisma.storage.updateMany({
          where: {
            id: { in: storages },
          },
          data: { isUploaded: true },
        }),
      ]);

      return moment;
    }


    return this.prisma.moment.create({
      data: {
        id: ID.primary(),
        userId,
        title,
        content,
      },
    });
  }

  @Query(() => [Moment])
  queryTimelineMoments(
    @Args('take', { type: () => Int, nullable: true }) take: number,
    @Args('skip', { type: () => Int, nullable: true }) skip: number,
  ): Promise<MomentInterface[]> {
    if (take < 0 || take > 100) {
      throw new Error('Take must be between 0 and 100.');
    } else if (skip < 0) {
      throw new Error('Skip must be greater than 0.');
    }

    return this.prisma.moment.findMany({
      take: take || 15,
      skip: skip || undefined,
      orderBy: { createdAt: 'desc' },
    });
  }

  @Query(() => [Moment])
  @Auth.must()
  queryFollowMoments(
    @Args('take', { type: () => Int, nullable: true }) take: number,
    @Args('skip', { type: () => Int, nullable: true }) skip: number,
    @Auth.accessToken() { userId }: AccessToken,
  ): Promise<MomentInterface[]> {
    if (take < 0 || take > 100) {
      throw new Error('Take must be between 0 and 100.');
    } else if (skip < 0) {
      throw new Error('Skip must be greater than 0.');
    }

    return this.prisma.moment.findMany({
      where: {
        user: {
          followers: {
            some: {
              userId,
            },
          },
        },
      },
      take: take || 15,
      skip: skip || undefined,
      orderBy: { createdAt: 'desc' },
    });
  }

  @Query(() => [Moment])
  queryUserMoments(
    @Args('take', { type: () => Int, nullable: true }) take: number,
    @Args('skip', { type: () => Int, nullable: true }) skip: number,
    @Args('userId', { type: () => String, nullable: false }) userId: string,
  ): Promise<MomentInterface[]> {
    if (take < 0 || take > 100) {
      throw new Error('Take must be between 0 and 100.');
    } else if (skip < 0) {
      throw new Error('Skip must be greater than 0.');
    }

    return this.prisma.moment.findMany({
      where: { userId },
      take: take || 15,
      skip: skip || undefined,
      orderBy: { createdAt: 'desc' },
    });
  }

  @ResolveField('storages', () => [String], { nullable: true })
  async resolveStoragesField(@Parent() { id }: MomentInterface) {
    const storageOnMoment = await this.prisma.storageOnMoment.findMany({
      where: { momentId: id },
    });

    return storageOnMoment.map(({ storageId }) => storageId);
  }
}
