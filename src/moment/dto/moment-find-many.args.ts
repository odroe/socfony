import { ArgsType, Field, Int } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';
import { MomentOrderByWithRelationInput } from './moment-order-by-with-relation.input';
import { MomentWhereUniqueInput } from './moment-where-unique.input';
import { MomentWhereInput } from './moment-where.input';

@ArgsType()
export class MomentFindManyArgs
  implements
    Pick<
      Prisma.MomentFindManyArgs,
      'where' | 'orderBy' | 'cursor' | 'take' | 'skip'
    >
{
  @Field(() => MomentWhereInput, { nullable: true })
  where?: Prisma.MomentWhereInput;

  @Field(() => [MomentOrderByWithRelationInput], { nullable: true })
  orderBy?: Prisma.MomentOrderByWithRelationInput[];

  @Field(() => MomentWhereUniqueInput, { nullable: true })
  cursor?: Prisma.MomentWhereUniqueInput;

  @Field(() => Int, { nullable: true, defaultValue: 15 })
  take?: number = 15;

  @Field(() => Int, { nullable: true })
  skip?: number;
}
