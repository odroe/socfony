import { ArgsType, Field, Int } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';
import { CommentOrderByWithRelationInput } from './comment-order-by-with-relation.input';
import { CommentWhereUniqueInput } from './comment-where-unique.input';
import { CommentWhereInput } from './comment-where.input';

@ArgsType()
export class CommentFindManyArgs
  implements
    Pick<
      Prisma.CommentFindManyArgs,
      'where' | 'orderBy' | 'cursor' | 'take' | 'skip'
    >
{
  @Field(() => CommentWhereInput, { nullable: true })
  where?: Prisma.CommentWhereInput;

  @Field(() => [CommentOrderByWithRelationInput], { nullable: true })
  orderBy?: Prisma.CommentOrderByWithRelationInput;

  @Field(() => CommentWhereUniqueInput, { nullable: true })
  cursor?: Prisma.CommentWhereUniqueInput;

  @Field(() => Int, { nullable: true, defaultValue: 15 })
  take?: number = 15;

  @Field(() => Int, { nullable: true })
  skip?: number;
}
