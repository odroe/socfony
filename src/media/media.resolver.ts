import { Args, Mutation, Parent, Query, ResolveField, Resolver } from '@nestjs/graphql';
import { nanoid } from 'nanoid';
import { Auth } from 'shared/auth/auth.decorator';
import { CreateUploadMediaArgs } from './dto/create_upload_media.args';
import { Media } from './entities/media.entity';

@Resolver(() => Media)
export class MediaResolver {
  @Mutation(() => Media)
  // @Auth()
  async createUploadMedia(
    @Args({ type: () => CreateUploadMediaArgs }) args: CreateUploadMediaArgs,
  ) {
    const { length, type } = args;

    const now = new Date();
    const year = now.getUTCFullYear();
    const month = (now.getUTCMonth() + 1).toString().padStart(2, '0');
    const day = now.getUTCDate().toString().padStart(2, '0');
    const hour = now.getUTCHours().toString().padStart(2, '0');
    const key = `${year}${month}${day}T${hour}Z/${nanoid(32)}${type}`;

    return { key, length };
  }

  @Query(() => Media)
  async media() {}

  @Query(() => [Media])
  async mediaList() {}

  @ResolveField(() => String)
  async url(@Parent() media: Media & Pick<CreateUploadMediaArgs, 'length'>) {
    const { length, key } = media;
  }
}
