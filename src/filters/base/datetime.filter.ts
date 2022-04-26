import { Field, GraphQLISODateTime, InputType } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';

@InputType()
export class DateTimeFilter implements Prisma.DateTimeFilter {
  @Field(() => GraphQLISODateTime, { nullable: true })
  equals?: Date;

  @Field(() => [GraphQLISODateTime], { nullable: true })
  in?: Date[];

  @Field(() => [GraphQLISODateTime], { nullable: true })
  notIn?: Date[];

  @Field(() => GraphQLISODateTime, { nullable: true })
  lt?: Date;

  @Field(() => GraphQLISODateTime, { nullable: true })
  lte?: Date;

  @Field(() => GraphQLISODateTime, { nullable: true })
  gt?: Date;

  @Field(() => GraphQLISODateTime, { nullable: true })
  gte?: Date;

  @Field(() => DateTimeFilter, { nullable: true })
  not?: Prisma.DateTimeFilter;
}
