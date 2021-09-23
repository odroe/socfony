import {
  Args,
  Mutation,
  Parent,
  ResolveField,
  Resolver,
} from '@nestjs/graphql';
import dayjs = require('dayjs');
import { nanoid } from 'nanoid';
import { Auth } from 'src/auth/auth.decorator';
import { FederationToken } from './entittes/federation-token.entity';
import { Media } from './entittes/media.entity';
import { MediaType } from './entittes/media.type';
import { MediaService } from './media.service';

@Resolver(() => Media)
export class MediaResolver {
  constructor(private readonly mediaService: MediaService) {}

  @Auth()
  @Mutation(() => Media, {
    description: 'Create upload token',
  })
  async createUploadToken(
    @Args('type', {
      description: 'The type of the resource.',
      type: () => MediaType,
    })
    type: MediaType,
  ): Promise<Media> {
    const resource = `${dayjs().format('YYYY/MM/DD')}/${nanoid(32)}.${type}`;
    const federationToken = await this.mediaService.upload(resource);

    return { resource, federationToken };
  }

  @Mutation(() => FederationToken, {
    description: 'Create doenload token',
  })
  createDownloadToken(
    @Args('resource', { description: 'Resource key', type: () => String })
    key: string,
  ): Promise<FederationToken> {
    return this.mediaService.download(key);
  }

  @ResolveField()
  federationToken(@Parent() { resource }: Media) {
    return this.createDownloadToken(resource);
  }
}
