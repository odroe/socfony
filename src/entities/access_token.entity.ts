import { Field, GraphQLISODateTime, ObjectType } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';

/**
 * Access token entity.
 */
@ObjectType({ description: 'Access token entity.' })
export class AccessTokenEntity
  implements
    Prisma.AccessTokenGetPayload<{
      include: {
        owner: false;
      };
    }>
{
  /**
   * Access token.
   * @var {string}
   */
  @Field(() => String, { nullable: false, description: 'Access token.' })
  token: string;

  /**
   * The access token owner ID.
   * @var {string}
   */
  @Field(() => String, {
    nullable: false,
    description: 'The access token owner ID.',
  })
  ownerId: string;

  /**
   * The access token created at date.
   */
  @Field(() => GraphQLISODateTime, {
    nullable: false,
    description: 'The access token created at date.',
  })
  createdAt: Date;

  /**
   * Access token expired at date.
   */
  @Field(() => GraphQLISODateTime, {
    nullable: false,
    description: 'Access token expired at date.',
  })
  expiredAt: Date;

  /**
   * The access token can be used to refresh the token before this time
   */
  @Field(() => GraphQLISODateTime, {
    nullable: false,
    description:
      'The access token can be used to refresh the token before this time.',
  })
  refreshExpiredAt: Date;
}
