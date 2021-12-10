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
import { UserProfile } from './entities/user_profile.entity';

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
  async updateUserProfileAvatar(
    @Args('key', { type: () => String }) key: string,
    @Auth.accessToken() { userId }: AccessToken,
  ) {
    const exists = await this.mediaService.exists(key, (data) => {
      const headers = data?.headers ?? {};
      let contentType: string = '';
      for (const key in headers) {
        if (key.toLowerCase() === 'content-type') {
          contentType = headers[key];
        }
      }

      return contentType.startsWith('image') && data?.statusCode === 200;
    });
    if (exists[key] !== true) {
      throw new Error('Image does not exist');
    }

    return this.prisma.userProfile.upsert({
      where: { userId },
      update: { avatar: key },
      create: { userId, avatar: key },
    });
  }
}
