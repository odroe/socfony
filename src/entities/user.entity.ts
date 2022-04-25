import { Field, ObjectType } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';

/**
 * User entity.
 */
@ObjectType({ description: 'User entity' })
export class UserEntity
  implements
    Omit<
      Prisma.UserGetPayload<{
        include: {
          profile: false;
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
  username: string | null;
}
