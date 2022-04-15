import { ArgsType, Field } from '@nestjs/graphql';

@ArgsType()
export class ResolveURLOnStorageBaseMetadataArgs {
  // Query string
  @Field(() => String, { nullable: true, description: 'HTTP query' })
  query?: string;

  // Headers string
  @Field(() => String, { nullable: true, description: 'HTTP headers' })
  headers?: string;
}
