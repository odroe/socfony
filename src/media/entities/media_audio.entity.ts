import { Field, ObjectType } from '@nestjs/graphql';
import { Media } from './media.entity';

@ObjectType()
export class MediaAudio {
  @Field(() => Media, { description: `Audio poster`, nullable: true })
  poster?: Media;

  @Field(() => Media, { description: `Audio file` })
  audio!: Media;
}
