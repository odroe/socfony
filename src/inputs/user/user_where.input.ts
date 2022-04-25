import { Field, InputType } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';
import { StringFilter } from 'src/filters';

@InputType({ description: 'User where input.' })
export class UserWhereInput implements Prisma.UserWhereInput {
  /**
   * AND logical operator
   */
  @Field(() => [UserWhereInput], {
    nullable: true,
    description: 'AND logical operator',
  })
  AND?: Prisma.UserWhereInput[];

  /**
   * OR logical operator
   */
  @Field(() => [UserWhereInput], {
    nullable: true,
    description: 'OR logical operator',
  })
  OR?: Prisma.UserWhereInput[];

  /**
   * NOT logical operator
   */
  @Field(() => [UserWhereInput], {
    nullable: true,
    description: 'NOT logical operator',
  })
  NOT?: Prisma.UserWhereInput[];

  /**
   * User [id] filter
   */
  @Field(() => StringFilter, {
    nullable: true,
    description: 'User [id] filter',
  })
  id?: Prisma.StringFilter;

  /**
   * User [username] filter
   */
  @Field(() => StringFilter, {
    nullable: true,
    description: 'User [username] filter',
  })
  username?: Prisma.StringFilter;
}
