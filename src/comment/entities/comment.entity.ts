import { Field, GraphQLISODateTime, ID, ObjectType } from '@nestjs/graphql';
import { Prisma, User as _User } from '@prisma/client';
import { User } from 'src/user/entities/user.entity';
import { Commentable } from './commentable.union';

@ObjectType()
export class Comment
  implements
    Omit<
      Prisma.CommentGetPayload<{
        include: {
          user: true;
        };
      }>,
      'momentId'
    >
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

  @Field(() => Commentable)
  commentable: typeof Commentable;
}
