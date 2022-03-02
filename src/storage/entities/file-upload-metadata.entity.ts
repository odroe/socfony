import { Field, ObjectType } from '@nestjs/graphql';

@ObjectType()
export class FileUploadMetadata {
  @Field(() => String, { description: 'File path.' })
  path: string;

  @Field(() => String, { description: 'File using PUT method uploading URI.' })
  uri: string;

  @Field(() => String, { description: 'Header for uploading files' })
  headers: string;
}
