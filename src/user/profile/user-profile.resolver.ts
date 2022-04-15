// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import {
  Args,
  ID,
  Mutation,
  Parent,
  Query,
  ResolveField,
  Resolver,
} from '@nestjs/graphql';
import {
  AccessToken,
  PrismaClient,
  User as _User,
  UserProfile as _UserProfile,
} from '@prisma/client';
import { Auth } from 'src/auth';
import { StorageService, TencentCloudObjectStorageClient } from 'src/storage';
import {
  findSupportedStorageMetadata,
  SupportedImageStorageMetadata,
} from 'src/storage/supported_storage_metadatas';
import { User } from '../entities/user.entity';
import { UserProfileUncheckedUpdateInput } from './dto/user-profile-unckecked-update.input';
import { UserProfile } from './entities/user-profile.entity';
import { UserProfileService } from './user-profile.service';

@Resolver(() => UserProfile)
export class UserProfileResolver {
  constructor(
    private readonly userProfileService: UserProfileService,
    private readonly prisma: PrismaClient,
    private readonly cos: TencentCloudObjectStorageClient,
    private readonly storage: StorageService,
  ) {}

  /**
   * Find user profile by user ID.
   * @param id User ID.
   * @returns UserProfile
   */
  @Query(() => UserProfile, {
    description: 'Find User profile',
  })
  async userProfile(
    @Args({ name: 'id', type: () => ID, description: 'User ID' }) id: string,
  ): Promise<_UserProfile> {
    const user = await this.prisma.user.findUnique({
      where: { id },
      rejectOnNotFound: () => new Error('User not found'),
    });

    return this.userProfileService.resolve(user);
  }

  /**
   * Update current user profile.
   * @param data Update user profile data.
   * @param param1 @author.accessToken()
   * @returns UserProfile
   */
  @Auth.must()
  @Mutation(() => UserProfile)
  async updateUserProfile(
    @Args({
      name: 'data',
      type: () => UserProfileUncheckedUpdateInput,
      description: 'User profile data',
    })
    data: UserProfileUncheckedUpdateInput,
    @Auth.accessToken() { userId }: AccessToken,
  ): Promise<_UserProfile> {
    // Resolve user profile.
    const profile = await this.userProfileService.resolve(userId);

    // Date without null item in data.
    const dataWithoutNull = Object.fromEntries(
      Object.entries(data).filter(([_key, value]) => value),
    );

    // If dataWithoutNull is empty, return profile.
    if (Object.keys(dataWithoutNull).length === 0) {
      return profile;
    }

    // Update user profile.
    return this.prisma.userProfile.update({
      where: { userId: profile.userId },
      data: dataWithoutNull,
    });
  }

  @Mutation(() => UserProfile)
  @Auth.must()
  async updateUserAvatar(
    @Args({ name: 'storageId', type: () => String }) id: string,
    @Auth.accessToken() { userId }: AccessToken,
  ) {
    const { location, id: storageId } = await this.prisma.storage.findFirst({
      where: { id, userId, isUploaded: false },
      select: { location: true, id: true },
      rejectOnNotFound: () => new Error('Storage not found or used'),
    });

    // Get object header data in COS
    const result = await this.cos.headObject({
      Bucket: this.cos.bucket,
      Region: this.cos.region,
      Key: location,
    });

    // Validate request success
    if (result.statusCode !== 200) {
      throw new Error('Request storage object failed');
    }

    // Get object content-type in headers
    const contentType: string | undefined = result.headers?.['content-type'];

    // contentType is enpty or `findSupportedStorageMetadata(contentType)` not instanceof `SupportedImageStorageMetadata` will throw error
    if (
      !contentType ||
      !(
        findSupportedStorageMetadata(contentType) instanceof
        SupportedImageStorageMetadata
      )
    ) {
      throw new Error('Storage not is supported image');
    }

    // Resolve user profile
    const profile = await this.userProfileService.resolve(userId);

    // Start update user profile and change storage uplodated status
    const [newProfile] = await this.prisma.$transaction([
      // Update user profile
      this.prisma.userProfile.update({
        where: { userId: profile.userId },
        data: { avatarStorageId: storageId },
      }),

      // Update storage uplodated status
      this.prisma.storage.update({
        where: { id: storageId },
        data: { isUploaded: true },
      }),
    ]);

    // Delete old avatar
    this.storage.delete(profile.avatarStorageId);

    return newProfile;
  }

  /**
   * Resolve user profile user field.
   * @param profile @Parent()
   * @returns User
   */
  @ResolveField(() => User)
  async user(@Parent() profile: UserProfile): Promise<_User> {
    if (!profile.user) {
      return this.prisma.user.findUnique({
        where: { id: profile.userId },
        rejectOnNotFound: () => new Error('User not found'),
      });
    }

    return profile.user;
  }
}
