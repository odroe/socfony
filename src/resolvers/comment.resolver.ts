import { Parent, ResolveField, Resolver } from '@nestjs/graphql';
import { CommentOnMoment, PrismaClient, User } from '@prisma/client';
import { CommentEntity, CommentOnMomentEntity, UserEntity } from 'src/entities';
import { UtilHelpers } from 'src/helpers';
import { UserService } from 'src/services';

@Resolver(() => CommentEntity)
export class CommentResolver {
  constructor(
    private readonly prisma: PrismaClient,
    private readonly userService: UserService,
  ) {}

  /**
   * Resolve publisher field.
   */
  @ResolveField('publisher', () => UserEntity)
  async resolvePublisherField(@Parent() parent: CommentEntity): Promise<User> {
    if (UtilHelpers.isNotEmpty(parent.publisher)) return parent.publisher;

    // Find user by id.
    return this.userService.findUniqueOrThrow({ id: parent.publisherId });
  }

  /**
   * Resolve onMoment field.
   */
  @ResolveField('onMoment', () => CommentOnMomentEntity, { nullable: true })
  async resolveOnMomentField(
    @Parent() parent: CommentEntity,
  ): Promise<CommentOnMoment | null> {
    if (UtilHelpers.isNotEmpty(parent.onMoment)) return parent.onMoment;

    return this.prisma.commentOnMoment.findUnique({
      where: { commentId: parent.id },
      rejectOnNotFound: false,
    });
  }
}
