import { Field, InputType, PartialType, PickType } from "@nestjs/graphql";
import { Prisma } from "@prisma/client";
import { LikeOnMomentEntity } from "src/entities";
import { DateTimeFilter } from "src/filters";

@InputType({ description: 'Like on moment where input' })
export class LikeOnMomentWhereInput extends PartialType(
  PickType(LikeOnMomentEntity, ['momentId', 'userId'] as const),
  InputType,
) implements Prisma.LikeOnMomentWhereInput {
  /**
   * AND logical operator
   */
  @Field(() => [LikeOnMomentWhereInput], { nullable: true })
  AND?: Prisma.LikeOnMomentWhereInput[];

  /**
   * OR logical operator
   */
  @Field(() => [LikeOnMomentWhereInput], { nullable: true })
  OR?: Prisma.LikeOnMomentWhereInput[];

  /**
   * NOT logical operator
   */
  @Field(() => [LikeOnMomentWhereInput], { nullable: true })
  NOT?: Prisma.LikeOnMomentWhereInput[];

  /**
   * Created at data time filter.
   */
  @Field(() => DateTimeFilter, { nullable: true })
  createdAt?: Prisma.DateTimeFilter;
}