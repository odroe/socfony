import { Field, InputType } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';

@InputType()
export class CommentOrderByWithRelationInput
  implements Omit<Prisma.CommentOrderByWithRelationInput, 'content'>
{
  @Field(() => Prisma.SortOrder, { nullable: true })
  id?: Prisma.SortOrder;

  @Field(() => Prisma.SortOrder, { nullable: true })
  userId?: Prisma.SortOrder;

  @Field(() => Prisma.SortOrder, { nullable: true })
  createdAt?: Prisma.SortOrder;
}
