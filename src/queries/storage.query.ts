import qs = require('qs');
import { Args, Query, Resolver } from '@nestjs/graphql';
import { StorageService } from 'src/services';
import { StoragePutUrlMetadataEntity } from 'src/entities';
import { StorageQuerySignedUrlArgs } from 'src/args';

@Resolver(() => StoragePutUrlMetadataEntity)
export class StorageQuery {
  constructor(private readonly storageService: StorageService) {}

  /**
   * query storage signed url.
   */
  @Query(() => String, {
    name: 'storageSignedUrl',
    description: 'query storage signed url',
    nullable: false,
  })
  queryStorageSignedUrl(
    @Args('id', { type: () => String }) id: string,
    @Args({ type: () => StorageQuerySignedUrlArgs })
    { headers, query }: StorageQuerySignedUrlArgs,
  ): Promise<string> {
    return this.storageService.createObjectURLByStorageId(id, {
      headers: headers ? qs.parse(headers) : undefined,
      query: query ? qs.parse(query) : undefined,
      expiresIn: /* 12 hours */ 12 * 60 * 60,
      method: 'GET',
    });
  }
}
