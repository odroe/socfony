import { Field, InputType } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';
import { DateTimeFilter, StringFilter } from 'src/graphql';
import { EnumGenderFilter } from './enum-gender.filter';

@InputType()
export class UserProfileWhereInput
  implements Omit<Prisma.UserProfileWhereInput, 'avatar' | 'user'>
{
  @Field(() => [UserProfileWhereInput], {
    nullable: true,
    description: 'And where inputs',
  })
  AND?: Prisma.UserProfileWhereInput[];

  @Field(() => [UserProfileWhereInput], {
    nullable: true,
    description: 'Or where inputs',
  })
  OR?: Prisma.UserProfileWhereInput[];

  @Field(() => [UserProfileWhereInput], {
    nullable: true,
    description: 'Not where inputs',
  })
  NOT?: Prisma.UserProfileWhereInput[];

  @Field(() => StringFilter, {
    nullable: true,
    description: 'Filter profile by user id',
  })
  userId?: Prisma.StringFilter;

  @Field(() => StringFilter, {
    nullable: true,
    description: 'Filter profile by name',
  })
  name?: Prisma.StringFilter;

  @Field(() => StringFilter, {
    nullable: true,
    description: 'Filter profile by bio',
  })
  bio?: Prisma.StringFilter;

  @Field(() => StringFilter, {
    nullable: true,
    description: 'Filter profile by location',
  })
  location?: Prisma.StringFilter;

  @Field(() => DateTimeFilter, {
    nullable: true,
    description: 'Filter profile by birthday',
  })
  birthday?: Prisma.DateTimeFilter;

  @Field(() => EnumGenderFilter, {
    nullable: true,
    description: 'Filter profile by gender',
  })
  gender?: Prisma.EnumGenderFilter;
}
