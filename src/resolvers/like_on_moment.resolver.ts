import { Parent, ResolveField, Resolver } from '@nestjs/graphql';
import { Moment, PrismaClient, User } from '@prisma/client';
import { LikeOnMomentEntity, MomentEntity, UserEntity } from 'src/entities';
import { ERROR_CODE_MOMENT_NOT_FOUND } from 'src/errorcodes';
import { UserService } from 'src/services';

@Resolver(() => LikeOnMomentEntity)
export class LikeOnMomentResolver {
  constructor(
    private readonly prisma: PrismaClient,
    private readonly userService: UserService,
  ) {}

  /**
   * Resolve user field.
   */
  @ResolveField('user', () => UserEntity)
  async resolveUserField(@Parent() parent: LikeOnMomentEntity): Promise<User> {
    if (parent.user) return parent.user;

    // Find user by id.
    return this.userService.findUniqueOrThrow({ id: parent.userId });
  }

  /**
   * Resolve moment field.
   */
  @ResolveField('moment', () => MomentEntity)
  async resolveMomentField(
    @Parent() parent: LikeOnMomentEntity,
  ): Promise<Moment> {
    if (parent.moment) return parent.moment;

    // Find user by id.
    return this.prisma.moment.findUnique({
      where: { id: parent.momentId },
      rejectOnNotFound: () => new Error(ERROR_CODE_MOMENT_NOT_FOUND),
    });
  }
}
