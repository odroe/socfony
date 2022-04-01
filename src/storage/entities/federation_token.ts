import { Field, ObjectType, GraphQLISODateTime } from '@nestjs/graphql';

@ObjectType()
export class FederationToken {
  @Field(() => GraphQLISODateTime)
  expiredAt: Date;

  @Field(() => String)
  token: string;

  @Field(() => String)
  secretId: string;

  @Field(() => String)
  secretKey: string;

  @Field(() => [String])
  prefix: string[];
}
