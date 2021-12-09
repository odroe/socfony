import { ArgsType, Field, Int, registerEnumType } from '@nestjs/graphql';

export enum MediaType {
  IMAGE_JPG = '.jpg',
  IMAGE_PNG = '.png',
  IMAGE_GIF = '.gif',
  IMAGE_WEBP = '.webp',
  VIDEO_MP4 = '.mp4',
  VIDEO_WEBM = '.webm',
  AUDIO_MP3 = '.mp3',
  AUDIO_WAV = '.wav',
}
registerEnumType(MediaType, {
  name: 'MediaType',
});

@ArgsType()
export class CreateUploadMediaArgs {
  @Field(() => Int)
  length!: number;

  @Field(() => MediaType)
  type!: MediaType;

  @Field(() => String)
  md5!: string;
}
