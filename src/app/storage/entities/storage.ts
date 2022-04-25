import { Field, GraphQLISODateTime, ID, ObjectType } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';

@ObjectType({})
export class Storage
  implements
    Prisma.StorageGetPayload<{
      select: {
        id: true;
        location: true;
        isUploaded: true;
        createdAt: true;
      };
    }>
{
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
