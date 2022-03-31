import { Field, ObjectType } from "@nestjs/graphql";

@ObjectType()
export class StorageMetadata {
  @Field(() => String)
  path: string;

  @Field(() => String)
  mimeType: string;

  @Field(() => String)
  md5: string;
}