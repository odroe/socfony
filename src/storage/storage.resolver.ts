import { Args, Parent, ResolveField, Resolver } from '@nestjs/graphql';
import { StorageService } from './storage.service';
import { File } from './entities';

@Resolver(() => File)
export class StorageResolver {
  constructor(private readonly storageService: StorageService) {}

  @ResolveField(() => File)
  url(
    @Parent() { path }: File,
    @Args({
      name: 'query',
      type: () => String,
      nullable: true,
      description: 'COS URL query params.',
    })
    query: string,
  ) {
    return this.storageService.createDowenloadUrl(path, query);
  }
}
