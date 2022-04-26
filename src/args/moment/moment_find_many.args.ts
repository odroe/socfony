import { ArgsType, Field, Int } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';
import {
  MomentOrderByWithRelationInput,
  MomentWhereInput,
  MomentWhereUniqueInput,
} from 'src/inputs';
import { PaginationArgs } from '../pagination.args';

@ArgsType()
export class MomentFindManyArgs
  extends PaginationArgs
  implements Prisma.MomentFindManyArgs
{
  /**
   * Filter, which Moments to fetch.
   */
  @Field(() => MomentWhereInput, {
    nullable: true,
    description: 'Filter, which Moments to fetch.',
  })
  where?: Prisma.MomentWhereInput;

  /**
   * Determine the order of Moments to fetch.
   */
  @Field(() => [MomentOrderByWithRelationInput], {
    nullable: true,
    description: 'Determine the order of Moments to fetch.',
  })
  orderBy?: Prisma.MomentOrderByWithRelationInput[];

  /**
   * Sets the position for listing Moments.
   */
  @Field(() => MomentWhereUniqueInput, {
    nullable: true,
    description: 'Sets the position for listing Moments.',
  })
  cursor?: Prisma.MomentWhereUniqueInput;
}
