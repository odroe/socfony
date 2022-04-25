import { Parent, ResolveField, Resolver } from '@nestjs/graphql';
import { PrismaClient, StorageOnMoment, User } from '@prisma/client';
import { MomentEntity, UserEntity } from 'src/entities';
import { UtilHelpers } from 'src/helpers';
import { UserService } from 'src/services';

function _unwrap(origin?: string[] | StorageOnMoment[] | null): string[] {
  if (UtilHelpers.isNotEmpty(origin)) {
    return origin!.map((element) =>
      typeof element === 'string' ? element : element.storageId,
    );
  }

  return [];
}

@Resolver(() => MomentEntity)
export class MomentResolver {
  constructor(
    private readonly userService: UserService,
    private readonly prisma: PrismaClient,
  ) {}

  /**
   * Resolve [publisher] field.
   */
  @ResolveField('publisher', () => UserEntity)
  async resolvePublisher(@Parent() parent: MomentEntity): Promise<User> {
    if (parent.publisher) return parent.publisher;

    // Find user by id.
    return this.userService.findUniqueOrThrow({ id: parent.publisherId });
  }

  /**
   * Resolve [storages] field.
   */
  @ResolveField('storages', () => [String])
  async resolveStorages(
    @Parent() { storages, id }: MomentEntity,
  ): Promise<string[]> {
    if (UtilHelpers.isNotEmpty(storages)) return _unwrap(storages);

    // Find all storage om moment.
    const many = await this.prisma.storageOnMoment.findMany({
      where: { momentId: id },
    });

    return _unwrap(many);
  }
}
