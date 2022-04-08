import { Field, ID, ObjectType } from '@nestjs/graphql';

@ObjectType()
export class UploadStorageMetadata {
  @Field(() => ID, { description: 'storage ID' })
  id: string;

  @Field(() => String, { description: 'PUT file url' })
  url: string;

  @Field(() => String, { description: 'HTTP headers' })
  headers: string;
}
