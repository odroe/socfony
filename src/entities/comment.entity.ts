import { Field, GraphQLISODateTime, ObjectType } from '@nestjs/graphql';
import { CommentOnMoment, Prisma, User } from '@prisma/client';
import { CommentOnMomentEntity } from './comment_on_moment.entity';
import { UserEntity } from './user.entity';

@ObjectType({ description: 'Comment entity' })
export class CommentEntity
  implements
    Prisma.CommentGetPayload<{
      include: {
        onMoment: true;
        publisher: true;
      };
    }>
{
  /**
   * Comment id.
   */
  @Field(() => String, {
    nullable: false,
    description: 'Comment id.',
  })
  id: string;

  /**
   * Comment content.
   */
  @Field(() => String, {
    nullable: false,
    description: 'Comment content.',
  })
  content: string;

  /**
   * Comment publisher id.
   */
  @Field(() => String, {
    nullable: false,
    description: 'Comment publisher id.',
  })
  publisherId: string;

  /**
   * Comment create at.
   */
  @Field(() => GraphQLISODateTime, {
    nullable: false,
    description: 'Comment create at.',
  })
  createdAt: Date;

  /**
   * The comment on moment.
   */
  @Field(() => CommentOnMomentEntity, {
    nullable: true,
    description: 'The comment on moment.',
  })
  onMoment: CommentOnMoment | null;

  /**
   * The comment publisher.
   */
  @Field(() => UserEntity, {
    nullable: false,
    description: 'The comment publisher.',
  })
  publisher: User;
}
