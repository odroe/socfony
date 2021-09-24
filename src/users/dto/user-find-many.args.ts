import { ArgsType, Field, Int, registerEnumType } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';
import { UserOrderByWithRelationInput } from './user-order-by-with-relation.input';
import { UserWhereUniqueInput } from './user-where-unique.input';
import { UserWhereInput } from './user-where.input';

// Register user scalar field enum.
registerEnumType(Prisma.UserScalarFieldEnum, {
  name: 'UserScalarFieldEnum',
});

@ArgsType()
export class UserFindManyArgs implements Prisma.UserFindManyArgs {
  @Field(() => UserWhereInput, {
    nullable: true,
    description: 'Filter, which Users to fetch.',
  })
  where?: Prisma.UserWhereInput;

  @Field(() => [UserOrderByWithRelationInput], {
    nullable: true,
    description: 'Ordering criteria for Users.',
  })
  orderBy?: Prisma.UserOrderByWithRelationInput[];

  @Field(() => UserWhereUniqueInput, {
    nullable: true,
    description: 'Sets the position for listing Users.',
  })
  cursor?: Prisma.UserWhereUniqueInput;

  @Field(() => Int, {
    nullable: true,
    description: 'Take `±n` Users from the position of the cursor.',
    defaultValue: 15,
  })
  take?: number = 15;

  @Field(() => Int, {
    nullable: true,
    description: 'Skip `n` Users from the position of the cursor.',
    defaultValue: 0,
  })
  skip?: number = 0;

  @Field(() => [Prisma.UserScalarFieldEnum], {
    nullable: true,
    description: 'distinct Users by selected field.',
  })
  distinct?: Prisma.UserScalarFieldEnum[];
}
