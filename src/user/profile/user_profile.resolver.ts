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
import { AccessToken, PrismaClient } from '@prisma/client';
import { Media } from 'media/entities/media.entity';
import { MediaService } from 'media/media.service';
import { Auth } from 'shared/auth/auth.decorator';
import { UpdateUserProfileInput } from './dto/update_user_profile.input';
import { UserProfile } from './entities/user_profile.entity';

/**
 * UserProfile resolver.
 */
@Resolver(() => UserProfile)
export class UserProfileResolver {
  constructor(
    private readonly prisma: PrismaClient,
    private readonly mediaService: MediaService,
  ) {}

  /**
   * Resolve the user's profile avatar field.
   *
   * @param parent Injected UserProfile object.
   * @returns Media object or null.
   */
  @ResolveField(() => Media, { nullable: true })
  avatar(@Parent() { avatar }: UserProfile) {
    // avatar is exists, return Media object.
    if (avatar) {
      return new Media(avatar);
    }

    return avatar;
  }

  /**
   * Update user profile avatar.
   *
   * @param key Injected media key for args.
   * @param accessToken Injected access token for auth.
   * @returns UserProfile object.
   */
  @Mutation(() => UserProfile)
  @Auth()
  async updateUserProfileAvatar(
    @Args('key', { type: () => String }) key: string,
    @Auth.accessToken() { userId }: AccessToken,
  ) {
    // Has media key exists
    const exists = await this.mediaService.exists(key, (data) => {
      // Get response headers.
      const headers = data?.headers ?? {};

      // Get response content type.
      let contentType: string = '';
      for (const key in headers) {
        if (key.toLowerCase() === 'content-type') {
          contentType = headers[key];
        }
      }

      // Has content type is image and status code is 200.
      return contentType.startsWith('image') && data?.statusCode === 200;
    });

    // Check media key exists.
    if (exists[key] !== true) {
      throw new Error('Image does not exist');
    }

    // Update or create user profile.
    return this.prisma.userProfile.upsert({
      where: { userId },
      update: { avatar: key },
      create: { userId, avatar: key },
    });
  }

  /**
   * Update user profile data.
   *
   * @param data Injected user profile data for args.
   * @param accessToken Injected access token for auth.
   * @returns UserProfile object.
   */
  @Mutation(() => UserProfile)
  @Auth()
  updateUserProfile(
    @Args('data', { type: () => UpdateUserProfileInput })
    data: UpdateUserProfileInput,
    @Auth.accessToken() { userId }: AccessToken,
  ) {
    // Remove data values is empty.
    const _data = Object.fromEntries<UpdateUserProfileInput>(
      Object.entries(data).filter(([_key, value]) => !!value),
    );

    // Update or create user profile.
    return this.prisma.userProfile.upsert({
      where: { userId },
      update: _data,
      create: { userId, ..._data },
    });
  }
}
