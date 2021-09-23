import { Field, ID, ObjectType, registerEnumType } from '@nestjs/graphql';
import { Gender, Prisma, User as UserInterface } from '@prisma/client';
import { User } from 'src/users/entities/user.entity';

export type UserProfileInclude = Record<
  keyof Pick<Prisma.UserProfileInclude, 'user'>,
  true
>;

type UserProfileInterface = Prisma.UserProfileGetPayload<{
  include: UserProfileInclude;
}>;

registerEnumType(Gender, {
  name: 'Gender',
});

@ObjectType()
export class UserProfile implements UserProfileInterface {
  @Field(() => ID, { description: 'Profile owner ID' })
  userId: string;

  @Field(() => User, { description: 'Profile owner' })
  user: UserInterface;

  @Field(() => String, { description: 'User display name', nullable: true })
  name: string;

  @Field(() => String, { description: 'User bio', nullable: true })
  bio: string;

  @Field(() => String, { description: 'User avatar', nullable: true })
  avatar: string;

  @Field(() => String, { description: 'User location', nullable: true })
  location: string;

  @Field(() => Date, { description: 'User birthday', nullable: true })
  birthday: Date;

  @Field(() => Gender, { description: 'User gender', nullable: true })
  gender: Gender;
}
