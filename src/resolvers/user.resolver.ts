import { Args, Int, Parent, ResolveField, Resolver } from '@nestjs/graphql';
import { PrismaClient } from '@prisma/client';
import { PaginationArgs } from 'src/args';
import {
  FollowOnUserEntity,
  MomentEntity,
  UserEntity,
  UserProfileEntity,
} from 'src/entities';
import {
  LikeOnMomentService,
  ResourceCountService,
  UserCountType,
  UserFollowService,
  UserProfileService,
} from 'src/services';

@Resolver(() => UserEntity)
export class UserResolver {
  constructor(
    private readonly userProfileService: UserProfileService,
    private readonly userFollowService: UserFollowService,
    private readonly prisma: PrismaClient,
    private readonly resourceCountService: ResourceCountService,
    private readonly likeOnMomentService: LikeOnMomentService,
  ) {}

  /**
   * Resolve profile field.
   */
  @ResolveField('profile', () => UserProfileEntity)
  async resolveProfileField(@Parent() { id, profile }: UserEntity) {
    if (profile) return profile;

    return this.userProfileService.resolve(id);
  }

  /**
   * Resolve following count field.
   */
  @ResolveField('followingCount', () => Int)
  async resolveFollowingCountField(@Parent() { id }: UserEntity) {
    const { count } = await this.userFollowService.followingCount(id);

    return count;
  }

  /**
   * Resolve followers count field.
   */
  @ResolveField('followersCount', () => Int)
  async resolveFollowersCountField(@Parent() { id }: UserEntity) {
    const { count } = await this.userFollowService.followersCount(id);

    return count;
  }

  /**
   * Resolve moments count field.
   */
  @ResolveField('momentsCount', () => Int)
  async resolveMomentsCountField(@Parent() { id }: UserEntity) {
    const { count } = await this.resourceCountService.get(
      UserCountType.moments,
      id,
      () => this.prisma.moment.count({ where: { publisherId: id } }),
    );

    return count;
  }

  /**
   * Resolve following field.
   */
  @ResolveField('following', () => [FollowOnUserEntity])
  async resolveFollowingField(
    @Parent() { id }: UserEntity,
    @Args({ type: () => PaginationArgs }) args: PaginationArgs,
  ) {
    return this.prisma.followOnUser.findMany({
      ...args,
      where: { ownerId: id },
      orderBy: { createdAt: 'desc' },
    });
  }

  /**
   * Resolve followers field.
   */
  @ResolveField('followers', () => [FollowOnUserEntity])
  async resolveFollowersField(
    @Parent() { id }: UserEntity,
    @Args({ type: () => PaginationArgs }) args: PaginationArgs,
  ) {
    return this.prisma.followOnUser.findMany({
      ...args,
      where: { targetId: id },
      orderBy: { createdAt: 'desc' },
    });
  }

  /**
   * Resolve moments field.
   */
  @ResolveField('moments', () => [MomentEntity])
  async resolveMomentsField(
    @Parent() { id }: UserEntity,
    @Args({ type: () => PaginationArgs }) args: PaginationArgs,
  ) {
    return this.prisma.moment.findMany({
      ...args,
      where: { publisherId: id },
      orderBy: { createdAt: 'desc' },
    });
  }

  /**
   * Resolve liked moments count field.
   */
  @ResolveField('likedMomentsCount', () => Int)
  resolveLikedMomentsCountField(@Parent() { id }: UserEntity) {
    return this.likeOnMomentService.userLikedMomentsCount(id);
  }

  /**
   * Resolve all published moment likers count field.
   */
  @ResolveField('allMomentLikersCount', () => Int)
  resolveAllMomentLikersCountField(@Parent() { id }: UserEntity) {
    return this.likeOnMomentService.userAllMomentLikersCount(id);
  }
}
