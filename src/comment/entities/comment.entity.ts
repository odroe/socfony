import { Field, ID, ObjectType } from '@nestjs/graphql';
import { Comment as $Comment } from '@prisma/client';
import { DateTime } from 'graphql/scalars/date_time.scalar';
import { User } from 'user/entities/user.entity';

@ObjectType()
export class Comment implements $Comment {
  @Field(() => ID)
  id!: string;

  @Field(() => String)
  body!: string;

  @Field(() => ID)
  userId!: string;

  @Field(() => DateTime)
  createdAt!: Date;

  @Field(() => User)
  user!: User;
}
