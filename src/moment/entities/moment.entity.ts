import { Field, GraphQLISODateTime, ID, ObjectType } from '@nestjs/graphql';
import { Prisma, User as _User, Comment as _Comment } from '@prisma/client';
import { Comment } from 'src/comment/entities/comment.entity';
import { User } from 'src/user/entities/user.entity';

@ObjectType()
export class Moment
  implements
    Prisma.MomentGetPayload<{
      include: {
        user: true;
        comments: true;
      };
    }>
{
  @Field(() => ID, { description: 'Moment ID' })
  id: string;

  @Field(() => ID, { description: 'The moment owner user ID.' })
  userId: string;

  @Field(() => String, { nullable: true, description: 'Moment title.' })
  title: string | null;

  @Field(() => String, { nullable: true, description: 'Moment content.' })
  content: string | null;

  @Field(() => [String], { nullable: true, description: 'Moment media.' })
  media: string[];

  @Field(() => GraphQLISODateTime, { description: 'Moment create at.' })
  createdAt: Date;

  @Field(() => User, { description: 'Moment owner user.' })
  user: _User;

  @Field(() => [User], {
    description: 'Users who like this moment.',
    nullable: 'items',
  })
  likedUsers: _User[];

  @Field(() => [Comment], {
    nullable: 'items',
    description: 'Moment comments.',
  })
  comments: _Comment[];
}
