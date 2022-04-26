import { Args, Int, Mutation, Resolver } from '@nestjs/graphql';
import { AccessToken, LikeOnMoment, PrismaClient } from '@prisma/client';
import { Auth } from 'src/auth';
import { LikeOnMomentEntity } from 'src/entities';
import { ERROR_CODE_MOMENT_NOT_FOUND } from 'src/errorcodes';
import { GraphQLException } from 'src/graphql.exception';
import { LikeOnMomentService } from 'src/services';

@Resolver(() => LikeOnMomentEntity)
export class LikeOnMomentMutation {
  constructor(
    private readonly likeOnMomentService: LikeOnMomentService,
    private readonly prisma: PrismaClient,
  ) {}

  /**
   * Like a moment.
   */
  @Mutation(() => LikeOnMomentEntity, {
    description: 'Like a moment.',
    nullable: false,
    name: 'likeMoment',
  })
  @Auth.must()
  async likeMomentMutation(
    @Auth.accessToken() { ownerId }: AccessToken,
    @Args('momentId', {
      nullable: false,
      type: () => String,
      description: 'liked moment id',
    })
    momentId: string,
  ): Promise<LikeOnMoment> {
    // Validate moment is exist.
    const { id } = await this.prisma.moment.findUnique({
      where: { id: momentId },
      select: { id: true },
      rejectOnNotFound: () => new GraphQLException(ERROR_CODE_MOMENT_NOT_FOUND),
    });

    return this.likeOnMomentService.like(ownerId, id);
  }

  /**
   * Unlike a moment.
   */
  @Mutation(() => Int, {
    description: 'Unlike a moment.',
    nullable: false,
    name: 'unlikeMoment',
  })
  @Auth.must()
  async unlikeMomentMutation(
    @Auth.accessToken() { ownerId }: AccessToken,
    @Args('momentId', {
      nullable: false,
      type: () => String,
      description: 'liked moment id',
    })
    momentId: string,
  ): Promise<number> {
    // Validate moment is exist.
    const { id } = await this.prisma.moment.findUnique({
      where: { id: momentId },
      select: { id: true },
      rejectOnNotFound: () => new GraphQLException(ERROR_CODE_MOMENT_NOT_FOUND),
    });

    await this.likeOnMomentService.unlike(ownerId, id);

    return this.likeOnMomentService.momentLikersCount(id);
  }
}
