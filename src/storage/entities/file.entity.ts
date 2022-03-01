import { Field, ObjectType } from '@nestjs/graphql';

@ObjectType()
export class File {
  @Field({ description: 'File path' })
  path: string;

  @Field({ description: 'Download URL.' })
  url: string;

  static fromPath(path: string): File {
    const file = new File();
    file.path = path;
    return file;
  }
}
