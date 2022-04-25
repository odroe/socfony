import { ObjectType, Field, GraphQLISODateTime } from '@nestjs/graphql';
import { Moment as MomentInterface } from '@prisma/client';

@ObjectType()
export class Moment implements MomentInterface {
  @Field(() => String, { description: 'The unique identifier for the moment.' })
  id: string;

  @Field(() => String, { description: 'The userId is moment publisher.' })
  userId: string;

  @Field(() => String, { description: 'The moment title.', nullable: true })
  title: string | null;

  @Field(() => String, { description: 'The moment content.', nullable: true })
  content: string | null;

  @Field(() => GraphQLISODateTime, { description: 'The moment created at.' })
  createdAt: Date;

  /// Append additional attributes here. - Start

  /**
   * Moment storages.
   */
  @Field(() => [String], { description: 'The moment storage', nullable: true })
  storages?: string[];

  /// Append additional attributes here. - End
}
