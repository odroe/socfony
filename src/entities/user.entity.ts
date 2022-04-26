import { Field, Int, ObjectType } from '@nestjs/graphql';
import { FollowOnUser, Moment, Prisma, UserProfile } from '@prisma/client';
import { FollowOnUserEntity } from './follow_on_user.entity';
import { MomentEntity } from './moment.entity';
import { UserProfileEntity } from './user_profile.entity';

/**
 * User entity.
 */
@ObjectType({ description: 'User entity' })
export class UserEntity
  implements
    Omit<
      Prisma.UserGetPayload<{
        include: {
          profile: true;
          following: true;
          followers: true;
          moments: true;
        };
      }>,
      'password' | 'phone' | 'email'
    >
{
  /**
   * User ID.
   */
  @Field(() => String, { description: 'User ID', nullable: false })
  id: string;

  /**
   * User unique name.
   */
  @Field(() => String, { description: 'User unique name', nullable: true })
  username: string;

  /**
   * User profile.
   */
  @Field(() => UserProfileEntity, {
    nullable: false,
    description: 'User profile',
  })
  profile: UserProfile;

  /**
   * Following count
   */
  @Field(() => Int, {
    nullable: false,
    description: 'Following count',
  })
  followingCount: number;

  /**
   * Followers count
   */
  @Field(() => Int, {
    nullable: false,
    description: 'Followers count',
  })
  followersCount: number;

  /**
   * User published moments count
   */
  @Field(() => Int, {
    nullable: false,
    description: 'User published moments count',
  })
  momentsCount: number;

  /**
   * User following
   */
  @Field(() => [FollowOnUserEntity], {
    nullable: false,
    description: 'User following',
  })
  following: FollowOnUser[];

  /**
   * User followers
   */
  @Field(() => [FollowOnUserEntity], {
    nullable: false,
    description: 'User followers',
  })
  followers: FollowOnUser[];

  /**
   * User published moments
   */
  @Field(() => [MomentEntity], {
    nullable: false,
    description: 'User published moments',
  })
  moments: Moment[];

  /**
   * The user liked moments count.
   */
  @Field(() => Int, {
    nullable: false,
    description: 'The user liked moments count.',
  })
  likedMomentsCount: number;

  /**
   * The user all published moment likers count.
   */
  @Field(() => Int, {
    nullable: false,
    description: 'The user all published moment likers count.',
  })
  allMomentLikersCount: number;
}
