import { Field, InputType } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';

@InputType()
export class MomentOrderByWithRelationInput
  implements
    Pick<
      Prisma.MomentOrderByWithRelationInput,
      'id' | 'userId' | 'title' | 'createdAt'
    >
{
  @Field(() => Prisma.SortOrder, { nullable: true })
  id?: Prisma.SortOrder;

  @Field(() => Prisma.SortOrder, { nullable: true })
  userId?: Prisma.SortOrder;

  @Field(() => Prisma.SortOrder, { nullable: true })
  title?: Prisma.SortOrder;

  @Field(() => Prisma.SortOrder, { nullable: true })
  createdAt?: Prisma.SortOrder;
}
