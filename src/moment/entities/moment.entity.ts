import { Field, GraphQLISODateTime, ID, ObjectType } from '@nestjs/graphql';
import { Prisma, User as _User } from '@prisma/client';
import { Media } from 'src/graphql';
import { User } from 'src/user/entities/user.entity';

@ObjectType()
export class Moment
  implements
    Prisma.MomentGetPayload<{
      include: {
        user: true;
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

  @Field(() => Media, { nullable: true, description: 'Moment media.' })
  media: Prisma.JsonValue;

  @Field(() => GraphQLISODateTime, { description: 'Moment create at.' })
  createdAt: Date;

  @Field(() => User, { description: 'Moment owner user.' })
  user: _User;
}
