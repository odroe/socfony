import { Field, InputType } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';
import { StringFilter } from 'src/filters';

@InputType()
export class UserWhereInput implements Prisma.UserWhereInput {
  @Field(() => [UserWhereInput], { nullable: true })
  AND?: Prisma.UserWhereInput[];

  @Field(() => [UserWhereInput], { nullable: true })
  OR?: Prisma.UserWhereInput[];

  @Field(() => [UserWhereInput], { nullable: true })
  NOT?: Prisma.UserWhereInput[];

  @Field(() => StringFilter, { nullable: true })
  id?: StringFilter;

  @Field(() => StringFilter, { nullable: true })
  username?: StringFilter;

  @Field(() => StringFilter, { nullable: true })
  email?: StringFilter;

  @Field(() => StringFilter, { nullable: true })
  phone?: StringFilter;
}
