import { Field, ObjectType } from '@nestjs/graphql';
import { File } from 'src/storage';

@ObjectType()
export class MediaImages {
  static fromPaths(paths: string[]): MediaImages {
    const entity = new MediaImages();
    entity.images = paths.map((path) => File.fromPath(path));

    return entity;
  }

  @Field(() => [File], { description: 'Media images.' })
  images: File[];
}
