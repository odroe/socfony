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
import { Auth, Helper, ID } from 'src/shared';
import {
  AccessToken,
  Prisma,
  PrismaClient,
  Moment as MomentInterface,
} from '@prisma/client';

@Resolver(() => Moment)
export class MomentsResolver {
  constructor(private readonly prisma: PrismaClient) {}

  /**
   * Create a moment.
   * @returns {Promise<MomentInterface>}
   */
  @Mutation(() => Moment)
  @Auth.must()
  createMoment(
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

    let storageOnMoment:
      | Prisma.StorageOnMomentUncheckedCreateNestedManyWithoutMomentInput
      | undefined;
    if (Helper.isNotEmpty(storages)) {
      storageOnMoment = {
        createMany: {
          skipDuplicates: true,
          data: Object.values(storages!).map((storageId) => ({ storageId })),
        },
      } as Prisma.StorageOnMomentUncheckedCreateNestedManyWithoutMomentInput;
    }

    return this.prisma.moment.create({
      data: {
        id: ID.primary(),
        userId,
        title,
        content,
        storages: storageOnMoment,
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

  @ResolveField('storages', () => [String])
  async resolveStoragesField(@Parent() { id }: MomentInterface) {
    const storageOnMoment = await this.prisma.storageOnMoment.findMany({
      where: { momentId: id },
    });

    return storageOnMoment.map(({ storageId }) => storageId);
  }
}
