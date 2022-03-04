import { Field, InputType } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';
import { UserWhereInput } from './user-where.input';

@InputType()
export class UserRelationFilter implements Prisma.UserRelationFilter {
  @Field(() => UserWhereInput, { nullable: true })
  is?: Prisma.UserWhereInput;

  @Field(() => UserWhereInput, { nullable: true })
  isNot?: Prisma.UserWhereInput;
}
