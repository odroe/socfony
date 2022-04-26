import { Field, InputType } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';
import { CommentOnMomentWhereInput } from 'src/inputs/comment_on_moment_where.input';

@InputType({ description: 'Comment on moment relation filter' })
export class CommentOnMomentRelationFilter
  implements Prisma.CommentOnMomentRelationFilter
{
  /**
   * is where
   */
  @Field(() => CommentOnMomentWhereInput, { nullable: true })
  is?: Prisma.CommentOnMomentWhereInput | null;

  /**
   * Is not where
   */
  @Field(() => CommentOnMomentWhereInput, { nullable: true })
  isNot?: Prisma.CommentOnMomentWhereInput | null;
}
