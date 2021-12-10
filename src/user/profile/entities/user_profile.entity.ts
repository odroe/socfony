import { Field, ID, Int, ObjectType, registerEnumType } from '@nestjs/graphql';
import {
  UserProfile as $UserProfile,
  UserProfile_gender,
} from '@prisma/client';
import { Media } from 'media/entities/media.entity';

registerEnumType(UserProfile_gender, {
  name: 'UserProfileGender',
});

@ObjectType()
export class UserProfile implements $UserProfile {
  @Field(() => ID)
  userId!: string;

  @Field(() => Media, { nullable: true })
  declare avatar: string | null;

  @Field(() => String, { nullable: true })
  declare name: string | null;

  @Field(() => String, { nullable: true })
  declare bio: string | null;

  @Field(() => Int, { nullable: true })
  declare birthday: number | null;

  @Field(() => UserProfile_gender, { defaultValue: UserProfile_gender.unknown })
  gender!: UserProfile_gender;
}
