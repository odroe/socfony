import { Field, GraphQLISODateTime, ObjectType } from '@nestjs/graphql';
import { Moment, Prisma, User } from '@prisma/client';
import { MomentEntity } from './moment.entity';
import { UserEntity } from './user.entity';

@ObjectType({ description: 'Like on moment entity' })
export class LikeOnMomentEntity
  implements
    Prisma.LikeOnMomentGetPayload<{
      include: {
        user: true;
        moment: true;
      };
    }>
{
  /**
   * Liked moment user id
   */
  @Field(() => String, {
    description: 'Liked moment user id',
    nullable: false,
  })
  userId: string;

  /**
   * User liked moment id
   */
  @Field(() => String, {
    description: 'User liked moment id',
    nullable: false,
  })
  momentId: string;

  /**
   * The user liked moment at.
   */
  @Field(() => GraphQLISODateTime, {
    description: 'The user liked moment at.',
    nullable: false,
  })
  createdAt: Date;

  /**
   * Liked the moment user
   */
  @Field(() => UserEntity, {
    description: 'Liked the moment user',
    nullable: false,
  })
  user: User;

  /**
   * The user liked moment
   */
  @Field(() => MomentEntity, {
    description: 'The user liked moment',
    nullable: false,
  })
  moment: Moment;
}
