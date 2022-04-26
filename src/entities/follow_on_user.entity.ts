import { Field, GraphQLISODateTime, ObjectType } from '@nestjs/graphql';
import { Prisma, User } from '@prisma/client';
import { UserEntity } from './user.entity';

@ObjectType({ description: 'Follow on User entity' })
export class FollowOnUserEntity
  implements
    Prisma.FollowOnUserGetPayload<{
      include: {
        owner: true;
        target: true;
      };
    }>
{
  /**
   * Owner id
   */
  @Field(() => String, {
    nullable: false,
    description: 'Owner id',
  })
  ownerId: string;

  /**
   * Target id
   */
  @Field(() => String, {
    nullable: false,
    description: 'Target id',
  })
  targetId: string;

  /**
   * The time when the owner follows the target
   */
  @Field(() => GraphQLISODateTime, {
    nullable: false,
    description: 'The time when the owner follows the target',
  })
  createdAt: Date;

  /**
   * Owner
   */
  @Field(() => UserEntity, {
    nullable: false,
    description: 'Owner',
  })
  owner: User;

  /**
   * Target
   */
  @Field(() => UserEntity, {
    nullable: false,
    description: 'Target',
  })
  target: User;
}
