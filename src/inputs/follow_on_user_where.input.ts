import { Field, InputType, PartialType, PickType } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';
import { FollowOnUserEntity } from 'src/entities';
import { DateTimeFilter } from 'src/filters';

@InputType({ description: 'Follow on user where input' })
export class FollowOnUserWhereInput
  extends PartialType(
    PickType(FollowOnUserEntity, ['ownerId', 'targetId'] as const),
    InputType,
  )
  implements Prisma.FollowOnUserWhereInput
{
  /**
   * AND logical operator
   */
  @Field(() => [FollowOnUserWhereInput], {
    nullable: true,
    description: 'AND logical operator',
  })
  AND?: Prisma.FollowOnUserWhereInput[];

  /**
   * OR logical operator
   */
  @Field(() => [FollowOnUserWhereInput], {
    nullable: true,
    description: 'OR logical operator',
  })
  OR?: Prisma.FollowOnUserWhereInput[];

  /**
   * NOT logical operator
   */
  @Field(() => [FollowOnUserWhereInput], {
    nullable: true,
    description: 'NOT logical operator',
  })
  NOT?: Prisma.FollowOnUserWhereInput[];

  /**
   * Created at date time filter
   */
  @Field(() => DateTimeFilter, {
    nullable: true,
    description: 'Created at date time filter',
  })
  createdAt?: Prisma.DateTimeFilter;
}
