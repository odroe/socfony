import { registerEnumType } from '@nestjs/graphql';

export enum MediaType {
  // Audio
  MP3 = 'mp3',
  WAV = 'wav',

  // Video
  MP4 = 'mp4',
  WEBM = 'webm',

  // image
  JPEG = 'jpg',
  PNG = 'png',
}

registerEnumType(MediaType, {
  name: 'MediaType',
  description: 'Media type',
});
