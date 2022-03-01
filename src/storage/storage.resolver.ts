import { Args, Parent, ResolveField, Resolver } from '@nestjs/graphql';
import { StorageService } from './storage.service';
import { File } from './entities';

@Resolver(() => File)
export class StorageResolver {
  constructor(private readonly storageService: StorageService) {}

  /**
   * Resolve the file path.
   * @param file Parent object.
   * @returns string
   */
  @ResolveField(() => File)
  path(@Parent() file: File | string) {
    if (typeof file === 'string') {
      return file;
    }

    return file.path;
  }

  @ResolveField(() => File)
  url(
    @Parent() file: File | string,
    @Args({
      name: 'query',
      type: () => String,
      nullable: true,
      description: 'COS URL query params.',
    })
    query: string,
  ) {
    return this.storageService.createDowenloadUrl(this.path(file), query);
  }
}
