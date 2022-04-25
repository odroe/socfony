import { Field, Int, ObjectType, registerEnumType } from '@nestjs/graphql';
import { Prisma, Storage, User, UserGender } from '@prisma/client';
import { UserEntity } from './user.entity';

registerEnumType(UserGender, {
  name: 'UserGender',
  description: 'User gender',
});

@ObjectType({ description: 'User profile entity' })
export class UserProfileEntity
  implements
    Prisma.UserProfileGetPayload<{
      include: {
        avatar: true;
        owner: true;
      };
    }>
{
  @Field(() => String, { nullable: false, description: 'Owner ID' })
  ownerId: string;

  /**
   * User avatar storage id.
   */
  @Field(() => String, { nullable: true, description: 'Avatar storage id' })
  avatarStorageId: string | null;

  /**
   * User bio.
   */
  @Field(() => String, { nullable: true, description: 'User bio' })
  bio: string | null;

  /**
   * User gender.
   */
  @Field(() => UserGender, { nullable: false, description: 'User gender' })
  gender: UserGender;

  /**
   * User birthday.
   */
  @Field(() => Int, { nullable: true, description: 'User birthday' })
  birthday: number | null;

  /**
   * The profile owner.
   */
  @Field(() => UserEntity, {
    nullable: false,
    description: 'The profile owner',
  })
  owner: User;

  /**
   * User avatar.
   */
  @Field(() => String, { nullable: true, description: 'User avatar' })
  avatar: Storage;
}
