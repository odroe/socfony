import { Field, ObjectType } from '@nestjs/graphql';
import { File } from 'src/storage';

@ObjectType()
export class MediaVideo {
  @Field(() => File, { description: 'Media video poster.' })
  poster: File;

  @Field(() => File, { description: 'Media video.' })
  video: File;
}
