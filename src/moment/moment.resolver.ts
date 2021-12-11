import {
  Args,
  Mutation,
  Parent,
  Query,
  ResolveField,
  Resolver,
} from '@nestjs/graphql';
import { AccessToken, PrismaClient } from '@prisma/client';
import { MultiMediaInput } from 'media/dto/multi_media.input';
import { nanoid } from 'nanoid';
import { Auth } from 'shared/auth/auth.decorator';
import { CreateMomentArgs } from './dto/create_moment.args';
import { Moment } from './entities/moment.entity';

@Resolver(() => Moment)
export class MomentResolver {
  constructor(private readonly prisma: PrismaClient) {}

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

  @Mutation(() => Moment)
  @Auth()
  async createMoment(
    @Auth.accessToken() { userId }: AccessToken,
    @Args({ type: () => CreateMomentArgs })
    { title, body, media }: CreateMomentArgs,
  ) {
    return this.prisma.moment.create({
      data: {
        title,
        body,
        media: MultiMediaInput.transfromArray(media),
        userId,
        id: nanoid(64),
      },
    });
  }
}
