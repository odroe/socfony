import { Field, GraphQLISODateTime, ID, ObjectType } from '@nestjs/graphql';
import { Storage as StorageInterface } from '@prisma/client';

@ObjectType({})
export class Storage implements Omit<StorageInterface, 'userId'> {
  @Field(() => ID)
  id: string;

  @Field(() => String)
  location: string;

  @Field(() => Boolean)
  isUploaded: boolean;

  @Field(() => GraphQLISODateTime)
  createdAt: Date;

  // Append url field
  @Field(() => String)
  url: string;
}
