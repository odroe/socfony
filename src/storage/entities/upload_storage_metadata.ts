import { Field, ObjectType } from '@nestjs/graphql';

@ObjectType()
export class UploadStorageMetadata {
  @Field(() => String, { description: 'PUT file url' })
  url: string;

  @Field(() => String, { description: 'HTTP headers' })
  headers: string;
}
