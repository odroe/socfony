import { Field, InputType } from "@nestjs/graphql";
import { Prisma } from "@prisma/client";

@InputType({ description: 'Moment order by with relation input' })
export class MomentOrderByWithRelationInput implements Prisma.MomentOrderByWithRelationInput {
  /**
   * Ordering by id
   */
  @Field(() => Prisma.SortOrder, {
    nullable: true,
    description: 'Moment order by id',
  })
  id?: Prisma.SortOrder;

  /**
   * Ordering by createdAt
   */
  @Field(() => Prisma.SortOrder, {
    nullable: true,
    description: 'Moment order by createdAt',
  })
  createdAt?: Prisma.SortOrder;
}