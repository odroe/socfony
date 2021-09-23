import { Field, GraphQLISODateTime, Int, ObjectType } from '@nestjs/graphql';

@ObjectType()
export class FederationToken {
  @Field(() => Int, { description: 'Temporary credentials expired time(Unix)' })
  expiredTime: number;

  @Field(() => GraphQLISODateTime, {
    description: 'Temporary credentials expired at(ISO)',
  })
  expiredAt: Date;

  @Field(() => String, { description: 'Temporary credentials token' })
  token: string;

  @Field(() => String, { description: 'Temporary credentials secret ID' })
  secretId: string;

  @Field(() => String, { description: 'Temporary credentials secret key' })
  secretKey: string;
}
