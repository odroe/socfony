import { Field, ObjectType } from '@nestjs/graphql';
import { Prisma, UserProfile } from '@prisma/client';
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
}
