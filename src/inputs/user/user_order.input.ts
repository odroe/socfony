import { Field, InputType } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';

@InputType({ description: 'User order input' })
export class UserOrderInput implements Prisma.UserOrderByWithRelationInput {
  /**
   * order by user id
   */
  @Field(() => Prisma.SortOrder, { nullable: true })
  id?: Prisma.SortOrder;

  /**
   * Order by username
   */
  @Field(() => Prisma.SortOrder, { nullable: true })
  username?: Prisma.SortOrder;
}
