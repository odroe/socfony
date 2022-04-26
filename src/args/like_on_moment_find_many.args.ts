import { ArgsType, Field } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';
import { LikeOnMomentWhereInput } from 'src/inputs';
import { PaginationArgs } from './pagination.args';

@ArgsType()
export class LikeOnMomentFindManyArgs
  extends PaginationArgs
  implements Prisma.LikeOnMomentFindManyArgs
{
  /**
   * Filter, which LikeOnMoments to fetch.
   */
  @Field(() => LikeOnMomentWhereInput, {
    nullable: true,
    description: 'Filter, which LikeOnMoments to fetch.',
  })
  where?: Prisma.LikeOnMomentWhereInput;
}
