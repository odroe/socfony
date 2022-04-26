import { ArgsType, Field } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';
import {
  CommentOrderByWithRelationInput,
  CommentWhereInput,
  CommentWhereUniqueInput,
} from 'src/inputs';
import { PaginationArgs } from './pagination.args';

@ArgsType()
export class CommentFindManyArgs
  extends PaginationArgs
  implements Prisma.CommentFindManyArgs
{
  /**
   * Filter, which Comments to fetch.
   */
  @Field(() => CommentWhereInput, {
    nullable: true,
    description: 'Filter, which Comments to fetch.',
  })
  where?: Prisma.CommentWhereInput;

  /**
   * Determine the order of Comments to fetch.
   */
  @Field(() => [CommentOrderByWithRelationInput], {
    nullable: true,
    description: 'Determine the order of Comments to fetch.',
  })
  orderBy?: Prisma.CommentOrderByWithRelationInput[];

  /**
   * Sets the position for listing Comments.
   */
  @Field(() => CommentWhereUniqueInput, {
    nullable: true,
    description: 'Sets the position for listing Comments.',
  })
  cursor?: Prisma.CommentWhereUniqueInput;
}
