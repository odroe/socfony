import { ArgsType, Field, Int } from '@nestjs/graphql';

@ArgsType()
export class PaginationArgs {
  @Field(() => Int, { defaultValue: 15, nullable: true })
  take!: number;

  @Field(() => Int, { defaultValue: 0, nullable: true })
  skip!: number;
}
