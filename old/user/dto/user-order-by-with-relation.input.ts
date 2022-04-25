import { Field, InputType } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';

@InputType()
export class UserOrderByWithRelationInput
  implements Prisma.UserOrderByWithRelationInput
{
  @Field(() => Prisma.SortOrder, { nullable: true })
  id?: Prisma.SortOrder;

  @Field(() => Prisma.SortOrder, { nullable: true })
  username?: Prisma.SortOrder;

  @Field(() => Prisma.SortOrder, { nullable: true })
  email?: Prisma.SortOrder;

  @Field(() => Prisma.SortOrder, { nullable: true })
  phone?: Prisma.SortOrder;
}
