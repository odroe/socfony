import { Field, ID, ObjectType } from '@nestjs/graphql';
import { User as $ } from '@prisma/client';
import { DateTime } from 'graphql/scalars/date_time.scalar';

@ObjectType()
export class User implements $ {
  @Field(() => ID)
  id!: string;

  @Field(() => String, { nullable: true })
  name!: string | null;

  @Field(() => String, { nullable: true })
  phone!: string | null;

  @Field(() => DateTime)
  createdAt!: Date;
}
