import { Args, Mutation, Resolver } from '@nestjs/graphql';
import { AccessToken, Prisma, PrismaClient } from '@prisma/client';
import { CreateMomentArgs } from 'src/args';
import { Auth } from 'src/auth';
import { MomentEntity } from 'src/entities';
import { ERROR_CODE_MOMENT_CONTENT_AND_STORAGES_IS_EMPTY } from 'src/errorcodes';
import { GraphQLException } from 'src/graphql.exception';
import { IDHelper, UtilHelpers } from 'src/helpers';
import {
  ResourceCountService,
  StorageService,
  supportedStorageMetadatas,
  UserCountType,
} from 'src/services';

@Resolver(() => MomentEntity)
export class MomentMutation {
  constructor(
    private readonly prisma: PrismaClient,
    private readonly storageService: StorageService,
    private readonly resourceCountService: ResourceCountService,
  ) {}

  @Mutation(() => MomentEntity, {
    name: 'createMoment',
    nullable: false,
    description: 'Create a moment.',
  })
  @Auth.must()
  async createMoment(
    @Auth.accessToken() { ownerId }: AccessToken,
    @Args({ type: () => CreateMomentArgs })
    { title, content, storages }: CreateMomentArgs,
  ) {
    // If content or storages is empty
    if (UtilHelpers.isEmpty(content) && UtilHelpers.isEmpty(storages)) {
      throw new GraphQLException(ERROR_CODE_MOMENT_CONTENT_AND_STORAGES_IS_EMPTY);
    }

    // Validate storages
    const allStorageUpdates = await Promise.all(
      (storages || []).map((storageId) =>
        this.storageService.validate(
          storageId as unknown as string,
          ownerId,
          supportedStorageMetadatas,
        ),
      ),
    );

    // Start transaction
    const [moment] = await this.prisma.$transaction([
      // Create a moment
      this.prisma.moment.create({
        data: {
          id: IDHelper.primary(),
          publisherId: ownerId,
          title,
          content,
          storages: {
            createMany: {
              skipDuplicates: true,
              data: (storages || []).map((storageId) => ({
                storageId: storageId as unknown as string,
              })),
            },
          },
        },
      }),

      // Update or create user published moment count.
      this.resourceCountService.upsert(
        UserCountType.moments,
        ownerId,
        { increment: 1 },
        1,
      ),

      // Update storages
      ...allStorageUpdates.map((fn) => fn()),
    ]);

    return moment;
  }
}
