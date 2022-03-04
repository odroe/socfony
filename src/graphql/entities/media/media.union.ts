import { createUnionType } from '@nestjs/graphql';
import { MediaImages } from './media-images.entity';
import { MediaVideo } from './media-video.entity';

export const Media = createUnionType({
  name: 'Media',
  types: () => [MediaImages, MediaVideo],
});
