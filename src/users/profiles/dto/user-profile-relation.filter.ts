import { Field, InputType } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';
import { UserProfileWhereInput } from './user-profile-where.input';

@InputType()
export class UserProfileRelationFilter
  implements Prisma.UserProfileRelationFilter
{
  @Field(() => UserProfileWhereInput, { nullable: true })
  is?: Prisma.UserProfileWhereInput;

  @Field(() => UserProfileWhereInput, { nullable: true })
  isNot?: Prisma.UserProfileWhereInput;
}
