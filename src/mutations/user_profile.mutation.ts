import { Args, Mutation, Resolver } from '@nestjs/graphql';
import { AccessToken, PrismaClient } from '@prisma/client';
import { UpdateUserProfileArgs } from 'src/args';
import { Auth } from 'src/auth';
import { UserProfileEntity } from 'src/entities';
import { ObjectHelper, UtilHelpers } from 'src/helpers';
import {
  StorageService,
  SupportedImageStorageMetadatas,
  UserProfileService,
} from 'src/services';

@Resolver(() => UserProfileEntity)
export class UserProfileMutation {
  constructor(
    private readonly prisma: PrismaClient,
    private readonly userProfileService: UserProfileService,
    private readonly storageService: StorageService,
  ) {}

  /**
   * Update authenticated user profile.
   */
  @Mutation(() => UserProfileEntity, {
    name: 'updateAuthenticatedUserProfile',
    nullable: false,
    description: 'Update authenticated user profile',
  })
  @Auth.must()
  async update(
    @Auth.accessToken() { ownerId }: AccessToken,
    @Args({ type: () => UpdateUserProfileArgs }) args: UpdateUserProfileArgs,
  ) {
    // Get without empty data.
    const dataWithoutEmpty = ObjectHelper.withoutEmpty(args);

    // If dataWithoutEmpty is empty, return resolve profile
    if (UtilHelpers.isEmpty(dataWithoutEmpty)) {
      return this.userProfileService.resolve(ownerId);
    }

    // Update or create user profile.
    return this.prisma.userProfile.upsert({
      where: { ownerId },
      create: { ...dataWithoutEmpty, ownerId },
      update: dataWithoutEmpty,
    });
  }

  /**
   * Update user avatar.
   */
  @Mutation(() => UserProfileEntity, {
    name: 'updateAuthenticatedUserAvatar',
    nullable: false,
    description: 'Update authenticated user avatar',
  })
  @Auth.must()
  async updateAvatar(
    @Auth.accessToken() { ownerId }: AccessToken,
    @Args({ name: 'storageId', type: () => String }) storageId: string,
  ) {
    // Validate and get storage update callback.
    const callback = await this.storageService.validate(
      storageId,
      ownerId,
      SupportedImageStorageMetadatas,
    );

    // get avatar old storage id.
    const { avatarStorageId } = await this.userProfileService.resolve(ownerId);

    const [profile] = await this.prisma.$transaction([
      // Update user profile.
      this.prisma.userProfile.update({
        where: { ownerId },
        data: { avatarStorageId: storageId },
      }),

      // Run storage update callback.
      callback(),
    ]);

    // Delete old avatar or and clear.
    this.storageService.deleteAndClear(avatarStorageId);

    return profile;
  }
}
