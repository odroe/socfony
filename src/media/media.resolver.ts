// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import {
  Args,
  Mutation,
  Parent,
  ResolveField,
  Resolver,
} from '@nestjs/graphql';
import { nanoid } from 'nanoid';
import { Auth } from 'shared/auth/auth.decorator';
import { CreateUploadMediaArgs } from './dto/create_upload_media.args';
import { Media } from './entities/media.entity';
import { MediaService } from './media.service';

@Resolver(() => Media)
export class MediaResolver {
  constructor(private readonly mediaService: MediaService) {}

  @Mutation(() => Media)
  @Auth()
  async createUploadMedia(
    @Args({ type: () => CreateUploadMediaArgs }) args: CreateUploadMediaArgs,
  ) {
    const { length, type, md5 } = args;

    const now = new Date();
    const year = now.getUTCFullYear();
    const month = (now.getUTCMonth() + 1).toString().padStart(2, '0');
    const day = now.getUTCDate().toString().padStart(2, '0');
    const hour = now.getUTCHours().toString().padStart(2, '0');
    const key = `${year}${month}${day}T${hour}Z/${nanoid(32)}${type}`;

    return { key, length, md5 };
  }

  @ResolveField(() => String)
  async url(
    @Parent() media: Media & Pick<CreateUploadMediaArgs, 'length' | 'md5'>,
    @Args('query', { type: () => String, nullable: true }) query: string,
  ) {
    const { length, key, md5 } = media;
    if (length && md5) {
      return this.mediaService.createUploadUrl(key, md5, length);
    } else if (key) {
      return this.mediaService.createDownloadUrl(key, query);
    }

    throw new Error('Invalid media key.');
  }
}
