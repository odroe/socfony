import { Field, InputType } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';
import { DateTimeFilter, StringFilter } from 'src/graphql';

@InputType()
export class CommentWhereInput
  implements Omit<Prisma.CommentWhereInput, 'content' | 'user' | 'moment'>
{
  @Field(() => [CommentWhereInput], { nullable: true })
  AND?: Prisma.CommentWhereInput[];

  @Field(() => [CommentWhereInput], { nullable: true })
  OR?: Prisma.CommentWhereInput[];

  @Field(() => [CommentWhereInput], { nullable: true })
  NOT?: Prisma.CommentWhereInput[];

  @Field(() => StringFilter, { nullable: true })
  id?: StringFilter;

  @Field(() => StringFilter, { nullable: true })
  userId?: Prisma.StringFilter;

  @Field(() => DateTimeFilter, { nullable: true })
  createdAt?: Prisma.DateTimeFilter;

  @Field(() => StringFilter, { nullable: true })
  momentId?: Prisma.StringFilter;
}
