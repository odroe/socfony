import { Field, InputType, PartialType, PickType } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';
import { CommentOnMomentEntity } from 'src/entities';

@InputType({ description: 'Comment on moment where input' })
export class CommentOnMomentWhereInput
  extends PartialType(
    PickType(CommentOnMomentEntity, ['commentId', 'momentId'] as const),
    InputType,
  )
  implements Prisma.CommentOnMomentWhereInput
{
  /**
   * AND logical operator
   */
  @Field(() => [CommentOnMomentWhereInput], { nullable: true })
  AND?: Prisma.CommentOnMomentWhereInput[];

  /**
   * OR logical operator
   */
  @Field(() => [CommentOnMomentWhereInput], { nullable: true })
  OR?: Prisma.CommentOnMomentWhereInput[];

  /**
   * NOT logical operator
   */
  @Field(() => [CommentOnMomentWhereInput], { nullable: true })
  NOT?: Prisma.CommentOnMomentWhereInput[];
}
