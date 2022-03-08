import { Field, ID, InputType } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';

@InputType()
export class CommentWhereUniqueInput implements Prisma.CommentWhereUniqueInput {
  @Field(() => ID, { nullable: true })
  id?: string;
}
