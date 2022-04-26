import { Args, Mutation, Resolver } from '@nestjs/graphql';
import { AccessToken, PrismaClient } from '@prisma/client';
import { Auth } from 'src/auth';
import { CommentOnMomentEntity } from 'src/entities';
import {
  ERROR_CODE_COMMENT_CONTENT_EMPTY,
  ERROR_CODE_MOMENT_NOT_FOUND,
} from 'src/errorcodes';
import { GraphQLException } from 'src/graphql.exception';
import { IDHelper, UtilHelpers } from 'src/helpers';
import {
  MomentCountType,
  ResourceCountService,
  UserCountType,
} from 'src/services';

@Resolver(() => CommentOnMomentEntity)
export class CommentOnMomentMutation {
  constructor(
    private readonly prisma: PrismaClient,
    private readonly resourceCountService: ResourceCountService,
  ) {}

  /**
   * Create a comment on moment.
   */
  @Mutation(() => CommentOnMomentEntity, {
    nullable: false,
    description: 'Create a comment on moment.',
    name: 'createCommentOnMoment',
  })
  @Auth.must()
  async createCommentOnMoment(
    @Auth.accessToken() { ownerId }: AccessToken,
    @Args('momentId', {
      nullable: false,
      description: 'Moment Id',
      type: () => String,
    })
    momentId: string,
    @Args('content', {
      nullable: false,
      description: 'Comment content.',
      type: () => String,
    })
    content: string,
  ) {
    // If content is empty, throw error.
    if (UtilHelpers.isEmpty(content)) {
      throw new GraphQLException(ERROR_CODE_COMMENT_CONTENT_EMPTY);
    }

    // Validate moment is exist.
    const { id } = await this.prisma.moment.findUnique({
      where: { id: momentId },
      rejectOnNotFound: () => new GraphQLException(ERROR_CODE_MOMENT_NOT_FOUND),
    });

    const [commentOnMoment] = await this.prisma.$transaction([
      // Create comment on moment.
      this.prisma.commentOnMoment.create({
        data: {
          moment: {
            connect: { id },
          },
          comment: {
            create: {
              id: IDHelper.primary(),
              content,
              publisherId: ownerId,
            },
          },
        },
        include: { comment: true },
      }),

      // Update moment comment count.
      this.resourceCountService.upsert(
        MomentCountType.comments,
        id,
        { increment: 1 },
        1,
      ),

      // Update or create user published comment count.
      this.resourceCountService.upsert(
        UserCountType.comments,
        ownerId,
        { increment: 1 },
        1,
      ),
    ]);

    return commentOnMoment;
  }
}
