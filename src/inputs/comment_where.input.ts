import { Field, InputType, PartialType, PickType } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';
import { CommentEntity } from 'src/entities';
import { CommentOnMomentRelationFilter, DateTimeFilter } from 'src/filters';

@InputType({ description: 'Comment where input' })
export class CommentWhereInput
  extends PartialType(
    PickType(CommentEntity, ['id', 'publisherId'] as const),
    InputType,
  )
  implements Prisma.CommentWhereInput
{
  /**
   * AND logical operator.
   */
  @Field(() => [CommentWhereInput], {
    nullable: true,
    description: 'AND logical operator.',
  })
  AND?: Prisma.CommentWhereInput[];

  /**
   * OR logical operator.
   */
  @Field(() => [CommentWhereInput], {
    nullable: true,
    description: 'OR logical operator.',
  })
  OR?: Prisma.CommentWhereInput[];

  /**
   * NOT logical operator.
   */
  @Field(() => [CommentWhereInput], {
    nullable: true,
    description: 'NOT logical operator.',
  })
  NOT?: Prisma.CommentWhereInput[];

  /**
   * Created at data time filter.
   */
  @Field(() => DateTimeFilter, {
    nullable: true,
    description: 'Created at data time filter.',
  })
  createdAt?: Prisma.DateTimeFilter;

  /**
   * onMoment relation filter.
   */
  @Field(() => CommentOnMomentRelationFilter, {
    nullable: true,
    description: 'onMoment relation filter.',
  })
  onMoment?: Prisma.CommentOnMomentRelationFilter;
}
