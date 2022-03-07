import { Field, GraphQLISODateTime, ID, ObjectType } from '@nestjs/graphql';
import { Prisma, User as _User } from '@prisma/client';
import { User } from 'src/user/entities/user.entity';

@ObjectType()
export class Comment
  implements
    Prisma.CommentGetPayload<{
      include: {
        user: true;
      };
    }>
{
  @Field(() => ID)
  id: string;

  @Field(() => String)
  content: string;

  @Field(() => ID)
  userId: string;

  @Field(() => GraphQLISODateTime)
  createdAt: Date;

  @Field(() => User)
  user: _User;
}
