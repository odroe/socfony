// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

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
