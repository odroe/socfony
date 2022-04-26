import { Field, InputType } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';

@InputType({ description: 'Comment order by with relation input' })
export class CommentOrderByWithRelationInput
  implements Prisma.CommentOrderByWithRelationInput
{
  /**
   * Ordering options for comment.createdAt
   */
  @Field(() => Prisma.SortOrder, {
    nullable: true,
    description: 'Ordering options for comment.createdAt',
  })
  createdAt?: Prisma.SortOrder;
}
