import { ArgsType, Field, Int } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';
import {
  UserOrderInput,
  UserWhereInput,
  UserWhereUniqueInput,
} from 'src/inputs';

@ArgsType()
export class UserFindManyArgs implements Prisma.UserFindManyArgs {
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

  /**
   * Take `±n` Users from the position of the cursor.
   */
  @Field(() => Int, {
    nullable: true,
    description: 'Take `±n` Users from the position of the cursor.',
    defaultValue: 15,
  })
  take: number = 15;

  /**
   * Skip the first `n` Users.
   */
  @Field(() => Int, {
    nullable: true,
    description: 'Skip the first `n` Users.',
    defaultValue: 0,
  })
  skip: number = 0;
}
