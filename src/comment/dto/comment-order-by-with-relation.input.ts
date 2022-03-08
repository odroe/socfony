import { Field, InputType } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';

@InputType()
export class CommentOrderByWithRelationInput
  implements
    Pick<
      Prisma.CommentOrderByWithRelationInput,
      'id' | 'userId' | 'createdAt' | 'momentId'
    >
{
  @Field(() => Prisma.SortOrder, { nullable: true })
  id?: Prisma.SortOrder;

  @Field(() => Prisma.SortOrder, { nullable: true })
  userId?: Prisma.SortOrder;

  @Field(() => Prisma.SortOrder, { nullable: true })
  createdAt?: Prisma.SortOrder;

  @Field(() => Prisma.SortOrder, { nullable: true })
  momentId?: Prisma.SortOrder;
}
