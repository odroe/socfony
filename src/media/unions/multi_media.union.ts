import { createUnionType } from '@nestjs/graphql';
import { Media } from '../entities/media.entity';
import { MediaAudio } from '../entities/media_audio.entity';
import { MediaVideo } from '../entities/media_video.entity';

export const MultiMediaUnion = createUnionType({
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
