import { ObjectType, Field } from '@nestjs/graphql';
import { Moment as MomentInterface } from '@prisma/client';

@ObjectType()
export class Moment implements MomentInterface {
  @Field(() => String, { description: 'The unique identifier for the moment.' })
  id: string;

  @Field(() => String, { description: 'The userId is moment publisher.' })
  userId: string;

  @Field(() => String, { description: 'The moment title.' })
  title: string | null;

  @Field(() => String, { description: 'The moment content.' })
  content: string | null;

  @Field(() => String, { description: 'The moment created at.' })
  createdAt: Date;
}
