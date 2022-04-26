import { ArgsType, Field, Int } from "@nestjs/graphql";
import { Prisma } from "@prisma/client";
import { MomentOrderByWithRelationInput, MomentWhereInput, MomentWhereUniqueInput } from "src/inputs";

@ArgsType()
export class MomentFindManyArgs implements Prisma.MomentFindManyArgs {
  /**
   * Filter, which Moments to fetch.
   */
  @Field(() => MomentWhereInput, {
    nullable: true,
    description: 'Filter, which Moments to fetch.',
  })
  where?: Prisma.MomentWhereInput;

  /**
   * Determine the order of Moments to fetch.
   */
  @Field(() => [MomentOrderByWithRelationInput], {
    nullable: true,
    description: 'Determine the order of Moments to fetch.',
  })
  orderBy?: Prisma.MomentOrderByWithRelationInput[];

  /**
   * Sets the position for listing Moments.
   */
  @Field(() => MomentWhereUniqueInput, {
    nullable: true,
    description: 'Sets the position for listing Moments.',
  })
  cursor?: Prisma.MomentWhereUniqueInput;

  /**
   * Take `±n` Moments from the position of the cursor.
   */
  @Field(() => Int, {
    nullable: true,
    description: 'Take `±n` Moments from the position of the cursor.',
    defaultValue: 15
  })
  take: number = 15;

  /**
   * Skip the first `n` Moments.
   */
  @Field(() => Int, {
    nullable: true,
    description: 'Skip the first `n` Moments.',
    defaultValue: 0
  })
  skip: number = 0;
}