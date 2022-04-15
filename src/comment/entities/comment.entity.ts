import { Field, GraphQLISODateTime, ID, ObjectType } from '@nestjs/graphql';
import { Comment as CommentInterfacd } from '@prisma/client';

@ObjectType()
export class Comment implements CommentInterfacd {
  @Field(() => ID)
  id: string;

  @Field(() => String)
  content: string;

  @Field(() => ID)
  userId: string;

  @Field(() => GraphQLISODateTime)
  createdAt: Date;
}
