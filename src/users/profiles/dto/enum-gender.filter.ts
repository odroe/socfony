import { Field, InputType } from '@nestjs/graphql';
import { Gender, Prisma } from '@prisma/client';

@InputType()
export class EnumGenderFilter implements Prisma.EnumGenderFilter {
  @Field(() => Gender, { nullable: true })
  equals?: Gender;

  @Field(() => [Gender], { nullable: true })
  in?: Gender[];

  @Field(() => [Gender], { nullable: true })
  notIn?: Gender[];

  @Field(() => EnumGenderFilter, { nullable: true })
  not?: Prisma.EnumGenderFilter;
}
