import { ArgsType, Field } from '@nestjs/graphql';

@ArgsType()
export class StorageQuerySignedUrlArgs {
  @Field(() => String, {
    nullable: false,
    description: 'Query the url request headers',
  })
  headers?: string;

  @Field(() => String, {
    nullable: true,
    description: 'Query the url request query',
  })
  query?: string;
}
