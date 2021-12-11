import { createUnionType } from '@nestjs/graphql';
import { Media } from './media.entity';
import { MediaAudio } from './media_audio.entity';
import { MediaVideo } from './media_video.entity';

export const MultiMedia = createUnionType({
  name: 'MultiMedia',
  types: () => [Media, MediaAudio, MediaVideo],
  resolveType: (value) => {
    if (typeof value === 'string') {
      return Media;
    } else if (typeof value === 'object' && value.audio) {
      return MediaAudio;
    } else if (typeof value === 'object' && value.video) {
      return MediaVideo;
    }
    return null;
  },
});
