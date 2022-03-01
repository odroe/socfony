import { Field, ObjectType } from '@nestjs/graphql';

@ObjectType()
export class File {
  @Field({ description: 'File path' })
  path: string;

  @Field({ description: 'Download URL.' })
  url: string;
}
