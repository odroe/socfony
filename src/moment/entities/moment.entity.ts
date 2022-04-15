import { Field, GraphQLISODateTime, ID, ObjectType } from '@nestjs/graphql';
import { Moment as MomentInterface } from '@prisma/client';

@ObjectType()
export class Moment implements MomentInterface {
  @Field(() => ID, { description: 'Moment ID' })
  id: string;

  @Field(() => ID, { description: 'The moment owner user ID.' })
  userId: string;

  @Field(() => String, { nullable: true, description: 'Moment title.' })
  title: string | null;

  @Field(() => String, { nullable: true, description: 'Moment content.' })
  content: string | null;

  @Field(() => GraphQLISODateTime, { description: 'Moment create at.' })
  createdAt: Date;
}
