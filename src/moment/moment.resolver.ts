import {
  Args,
  Int,
  Mutation,
  Parent,
  Query,
  ResolveField,
  Resolver,
} from '@nestjs/graphql';
import { AccessToken, PrismaClient } from '@prisma/client';
import { PaginationArgs } from 'graphql/args/pagination.args';
import {
  MultiMediaInput,
  MultiMediaItemType,
  MultiMediaTransfromReturn,
} from 'media/dto/multi_media.input';
import { MediaService } from 'media/media.service';
import { nanoid } from 'nanoid';
import { Auth } from 'shared/auth/auth.decorator';
import { CreateMomentArgs } from './dto/create_moment.args';
import { Moment } from './entities/moment.entity';

@Resolver(() => Moment)
export class MomentResolver {
  constructor(
    private readonly prisma: PrismaClient,
    private readonly mediaService: MediaService,
  ) {}

  @ResolveField()
  media(@Parent() { media }: Moment) {
    if (Array.isArray(media)) {
      return media;
    }

    return [media];
  }

  @ResolveField()
  user(@Parent() { userId }: Moment) {
    return this.prisma.user.findUnique({
      where: { id: userId },
    });
  }

  @ResolveField()
  async comments(
    @Parent() { id }: Moment,
    @Args({ type: () => PaginationArgs }) { take, skip }: PaginationArgs,
  ) {
    const commentOnMomentList = await this.prisma.commentOnMoment.findMany({
      where: { momentId: id },
      orderBy: { createdAt: 'desc' },
      take,
      skip,
      select: { commentId: true },
    });
    const commentIds = commentOnMomentList.map(({ commentId }) => commentId);

    if (commentIds.length === 0) {
      return [];
    }

    return this.prisma.comment.findMany({
      where: {
        id: { in: commentIds },
      },
      orderBy: { createdAt: 'desc' },
    });
  }

  @Mutation(() => Moment)
  @Auth()
  async createMoment(
    @Auth.accessToken() { userId }: AccessToken,
    @Args({ type: () => CreateMomentArgs })
    { title, body, media }: CreateMomentArgs,
  ) {
    const valudatedMedia = await this.validateMedia(media);
    return this.prisma.moment.create({
      data: {
        title,
        body,
        media: valudatedMedia,
        userId,
        id: nanoid(64),
      },
    });
  }

  private async validateMedia(
    media?: MultiMediaInput[],
  ): Promise<MultiMediaTransfromReturn[] | undefined> {
    for await (const iterator of media ?? []) {
      switch (iterator.type) {
        case MultiMediaItemType.AUDIO:
          const hasAudio = await this.hasMediaExists(iterator.src!, 'audio');
          if (!hasAudio) {
            throw new Error('Audio not found');
          }
          if (iterator.poster) {
            const hasPoster = await this.hasMediaExists(
              iterator.poster!,
              'image',
            );
            if (!hasPoster) {
              throw new Error('Poster not found');
            }
          }
          break;
        case MultiMediaItemType.IMAGE:
          const hasImage = await this.hasMediaExists(iterator.src!, 'image');
          if (!hasImage) {
            throw new Error('Image not found');
          }
          break;
        case MultiMediaItemType.VIDEO:
          const hasVideo = await this.hasMediaExists(iterator.src!, 'video');
          if (!hasVideo) {
            throw new Error('Video not found');
          }
          const hasPoster = await this.hasMediaExists(
            iterator.poster!,
            'image',
          );
          if (!hasPoster) {
            throw new Error('Poster not found');
          }
          break;
      }
    }

    return MultiMediaInput.transfromArray(media);
  }

  private async hasMediaExists(
    key: string,
    type: 'image' | 'audio' | 'video',
  ): Promise<boolean> {
    const exists = await this.mediaService.exists(key, (data) => {
      const headers = data?.headers ?? {};
      let contentType: string = '';

      for (const key in headers) {
        if (key.toLowerCase() === 'content-type') {
          contentType = headers[key];
        }
      }

      return contentType.startsWith(type) && data?.statusCode === 200;
    });

    return exists[key];
  }
}
