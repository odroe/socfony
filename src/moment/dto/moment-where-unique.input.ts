import { Field, ID, InputType } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';

@InputType()
export class MomentWhereUniqueInput implements Prisma.MomentWhereUniqueInput {
  @Field(() => ID, { nullable: true })
  id?: string;
}
