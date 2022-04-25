import { Args, Parent, ResolveField, Resolver } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';
import QueryString = require('qs');
import { StorageQuerySignedUrlArgs } from 'src/args';
import { UserEntity, UserProfileEntity } from 'src/entities';
import { UtilHelpers } from 'src/helpers';
import { StorageService, UserService } from 'src/services';

@Resolver(() => UserProfileEntity)
export class UserProfileResolver {
  constructor(
    private readonly userService: UserService,
    private readonly storageService: StorageService,
  ) {}

  /**
   * Resolve owner field.
   */
  @ResolveField('owner', () => UserEntity)
  async resolveOwnerField(@Parent() { ownerId, owner }: UserProfileEntity) {
    if (owner) return owner;

    return this.userService.findUniqueOrThrow({ id: ownerId });
  }

  /**
   * Resolve avatar field.
   */
  @ResolveField('avatar', () => String)
  async resolveAvatarField(
    @Parent()
    profile: Prisma.UserProfileGetPayload<{
      include: {
        avatar: true;
      };
    }>,
    @Args({ type: () => StorageQuerySignedUrlArgs })
    args: StorageQuerySignedUrlArgs,
  ) {
    // If profile,avatarStorageId isEmpty, return null.
    if (UtilHelpers.isEmpty(profile.avatarStorageId)) return null;

    // Parse query.
    const query = UtilHelpers.isEmpty(args.headers)
      ? undefined
      : QueryString.parse(args.headers!);

    // Parse headers.
    const headers = UtilHelpers.isEmpty(args.query)
      ? undefined
      : QueryString.parse(args.query!);

    // Expires in 12 hours.
    const expiresIn = 12 * 60 * 60;

    // If profile.avatar is not empty, return url by location.
    if (UtilHelpers.isNotEmpty(profile.avatar)) {
      return this.storageService.createObjectURLBylocation(
        profile.avatar!.location,
        {
          headers,
          query,
          expiresIn,
          method: 'GET',
        },
      );
    }

    // Create url by storage id.
    return this.storageService.createObjectURLByStorageId(
      profile.avatarStorageId!,
      {
        headers,
        query,
        expiresIn,
        method: 'GET',
      },
    );
  }
}
