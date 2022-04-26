import { ArgsType, Field } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';
import { FollowOnUserWhereInput } from 'src/inputs';
import { PaginationArgs } from './pagination.args';

@ArgsType()
export class FollowOnUserFindManyArgs
  extends PaginationArgs
  implements Prisma.FollowOnUserFindManyArgs
{
  /**
   * Filter, which FollowOnUsers to fetch.
   */
  @Field(() => FollowOnUserWhereInput, {
    nullable: true,
    description: 'Filter, which FollowOnUsers to fetch.',
  })
  where?: Prisma.FollowOnUserWhereInput;
}
