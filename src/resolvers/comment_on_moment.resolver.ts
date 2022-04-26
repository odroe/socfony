import { Parent, ResolveField, Resolver } from '@nestjs/graphql';
import { Comment, Moment, PrismaClient } from '@prisma/client';
import {
  CommentEntity,
  CommentOnMomentEntity,
  MomentEntity,
} from 'src/entities';
import { ERROR_CODE_COMMENT_NOT_FOUND } from 'src/errorcodes';
import { GraphQLException } from 'src/graphql.exception';
import { UtilHelpers } from 'src/helpers';

@Resolver(() => CommentOnMomentEntity)
export class CommentOnMomentResolver {
  constructor(private readonly prisma: PrismaClient) {}

  /**
   * Resolve [comment] field.
   */
  @ResolveField('comment', () => CommentEntity)
  async resolveCommentField(
    @Parent() parent: CommentOnMomentEntity,
  ): Promise<Comment> {
    if (UtilHelpers.isNotEmpty(parent.comment)) return parent.comment;

    return this.prisma.comment.findUnique({
      where: { id: parent.commentId },
      rejectOnNotFound: () =>
        new GraphQLException(ERROR_CODE_COMMENT_NOT_FOUND),
    });
  }

  /**
   * Resolve [moment] field.
   */
  @ResolveField('moment', () => MomentEntity)
  async resolveMomentField(
    @Parent() parent: CommentOnMomentEntity,
  ): Promise<Moment> {
    if (UtilHelpers.isNotEmpty(parent.moment)) return parent.moment;

    return this.prisma.moment.findUnique({
      where: { id: parent.momentId },
      rejectOnNotFound: () =>
        new GraphQLException(ERROR_CODE_COMMENT_NOT_FOUND),
    });
  }
}
