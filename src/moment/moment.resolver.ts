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
  Prisma,
  PrismaClient,
  Moment as _Moment,
  User as _User,
  PrismaPromise,
  AccessToken,
  prisma,
} from '@prisma/client';
import { nanoid } from 'nanoid';
import { Auth } from 'src/auth';
import { User } from 'src/user/entities/user.entity';
import { MomentCreateInput } from './dto/moment-create.input';
import { MomentFindManyArgs } from './dto/moment-find-many.args';
import { Moment } from './entities/moment.entity';

@Resolver(() => Moment)
export class MomentResolver {
  constructor(private readonly prisma: PrismaClient) {}

  @Query(() => Moment, { nullable: true, description: 'Find a moment.' })
  moment(
    @Args({ name: 'id', type: () => ID, description: 'Moment ID.' }) id: string,
  ): Prisma.Prisma__MomentClient<_Moment | null> {
    return this.prisma.moment.findUnique({
      where: { id },
      rejectOnNotFound: false,
    });
  }

  @Query(() => [Moment], { description: 'Find moments.', nullable: 'items' })
  moments(
    @Args({ type: () => MomentFindManyArgs }) args: MomentFindManyArgs,
  ): PrismaPromise<_Moment[]> {
    return this.prisma.moment.findMany(args);
  }

  @Mutation(() => Moment, { description: 'Create a moment.' })
  @Auth.must()
  createMoment(
    @Args({ name: 'data', type: () => MomentCreateInput })
    { images, video, title, content }: MomentCreateInput,
    @Auth.accessToken() { userId }: AccessToken,
  ): Prisma.Prisma__MomentClient<_Moment> {
    if (
      (!images || images.length === 0) &&
      (!video || !video.poster || !video.video) &&
      !content
    ) {
      throw new Error(
        'Moment must have at least one media, Or content is required.',
      );
    } else if (
      (images && images.length > 0) ||
      (video && video.poster && video.video)
    ) {
      throw new Error('Moment can not have both images and video.');
    }

    let media:
      | string[]
      | {
          poster: string;
          video: string;
        }
      | undefined;
    if (images && images.length > 0) {
      media = images;
    } else if (video && video.poster && video.video) {
      media = video;
    }

    return this.prisma.moment.create({
      data: {
        id: nanoid(64),
        userId,
        title,
        content,
        media,
      },
    });
  }

  @ResolveField(() => User)
  user(
    @Parent()
    { userId, user }: Prisma.MomentGetPayload<{ include: { user: true } }>,
  ): Prisma.Prisma__UserClient<_User> | Promise<_User> {
    if (user) return Promise.resolve<_User>(user);

    return this.prisma.user.findUnique({
      where: { id: userId },
      rejectOnNotFound: true,
    });
  }
}
