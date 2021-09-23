import { Field, ObjectType } from '@nestjs/graphql';
import { FederationToken } from './federation-token.entity';

@ObjectType()
export class Media {
  @Field(() => String, { description: 'Resource key' })
  resource: string;

  @Field(() => FederationToken, { description: 'Federation token' })
  federationToken: FederationToken;
}
