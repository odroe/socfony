import { Field, InputType } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';

@InputType()
export class UserOrderByWithRelationInput
  implements
    Omit<Prisma.UserOrderByWithRelationInput, 'accessTokens' | 'profile'>
{
  @Field(() => Prisma.SortOrder, { nullable: true })
  id?: Prisma.SortOrder;

  @Field(() => Prisma.SortOrder, { nullable: true })
  email?: Prisma.SortOrder;

  @Field(() => Prisma.SortOrder, { nullable: true })
  name?: Prisma.SortOrder;

  @Field(() => Prisma.SortOrder, { nullable: true })
  phone?: Prisma.SortOrder;

  @Field(() => Prisma.SortOrder, { nullable: true })
  registeredAt?: Prisma.SortOrder;
}
