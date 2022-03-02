import { ArgsType, Field, Int } from '@nestjs/graphql';

@ArgsType()
export class CreateFileUploadMetadataArgs {
  @Field(() => Int, { description: 'Origin file bytes size.' })
  size: number;

  @Field(() => String, {
    description: 'Origin file 16 digest Base64 encoded value.',
  })
  hash: string;

  @Field(() => String, { description: 'File content type.' })
  contentType: string;
}
