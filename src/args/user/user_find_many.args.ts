import { ArgsType, Field, Int } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';
import {
  UserOrderInput,
  UserWhereInput,
  UserWhereUniqueInput,
} from 'src/inputs';
import { PaginationArgs } from '../pagination.args';

@ArgsType()
export class UserFindManyArgs
  extends PaginationArgs
  implements Prisma.UserFindManyArgs
{
  /**
   * Filter, which Users to fetch.
   */
  @Field(() => UserWhereInput, {
    nullable: false,
    description: 'Filter, which Users to fetch.',
  })
  where?: Prisma.UserWhereInput;

  /**
   * Determine the order of Users to fetch.
   */
  @Field(() => UserOrderInput, {
    nullable: true,
    description: 'Determine the order of Users to fetch.',
  })
  orderBy?: Prisma.UserOrderByWithRelationInput;

  /**
   * Sets the position for listing Users.
   */
  @Field(() => UserWhereUniqueInput, {
    nullable: true,
    description: 'Sets the position for listing Users.',
  })
  cursor?: Prisma.UserWhereUniqueInput;
}
