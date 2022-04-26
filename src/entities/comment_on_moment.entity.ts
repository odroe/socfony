import { Field, ObjectType } from '@nestjs/graphql';
import { Comment, Moment, Prisma } from '@prisma/client';
import { CommentEntity } from './comment.entity';
import { MomentEntity } from './moment.entity';

@ObjectType({ description: 'Comment on moment entity' })
export class CommentOnMomentEntity
  implements
    Prisma.CommentOnMomentGetPayload<{
      include: {
        comment: true;
        moment: true;
      };
    }>
{
  /**
   * Comment ID.
   */
  @Field(() => String, {
    nullable: false,
    description: 'Comment ID.',
  })
  commentId: string;

  /**
   * Moment ID.
   */
  @Field(() => String, {
    nullable: false,
    description: 'Moment ID.',
  })
  momentId: string;

  /**
   * Comment.
   */
  @Field(() => CommentEntity, {
    nullable: false,
    description: 'Comment.',
  })
  comment: Comment;

  /**
   * Moment.
   */
  @Field(() => MomentEntity, {
    nullable: false,
    description: 'Moment.',
  })
  moment: Moment;
}
