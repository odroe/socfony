import { Field, GraphQLISODateTime, ID, ObjectType } from '@nestjs/graphql';
import { Prisma, UserProfile as UserProfileInterface } from '@prisma/client';
import { UserProfile } from '../profiles/entities/profile.entity';

export type UserInclude = Record<
  keyof Pick<Prisma.UserInclude, 'profile'>,
  true
>;

type UserInterface = Prisma.UserGetPayload<{ include: UserInclude }>;

@ObjectType()
export class User implements UserInterface {
  @Field(() => ID, { description: "The user's ID" })
  id: string;

  @Field(() => String, { nullable: true, description: "The user's name" })
  name: string;

  @Field(() => String, { nullable: true, description: "The user's email" })
  email: string;

  @Field(() => String, {
    nullable: true,
    description: "The User's phone number",
  })
  phone: string;

  @Field(() => GraphQLISODateTime, { description: "The user's registered at." })
  registeredAt: Date;

  @Field(() => UserProfile, { description: 'User profile.' })
  profile: UserProfileInterface;
}
