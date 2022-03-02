import {
  Args,
  Mutation,
  Parent,
  ResolveField,
  Resolver,
} from '@nestjs/graphql';
import { StorageService } from './storage.service';
import { File, FileUploadMetadata } from './entities';
import { Auth } from 'src/auth';
import { CreateFileUploadMetadataArgs } from './dto/create-file-upload-metadata.args';

const FILE_MIME_TYPES = [
  'image/jpeg',
  'image/png',
  'image/webp',
  'video/mp4',
  'video/webm',
];

@Resolver(() => File)
export class StorageResolver {
  constructor(private readonly storageService: StorageService) {}

  /**
   * Resolve File entity url field.
   * @param {File} file
   * @param query COS URL query params.
   * @returns string
   */
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

  @Auth.must()
  @Mutation(() => FileUploadMetadata)
  async createFileUploadMetadata(
    @Args({ type: () => CreateFileUploadMetadataArgs })
    args: CreateFileUploadMetadataArgs,
  ): Promise<FileUploadMetadata> {
    const { size, contentType, hash } = args;

    if (!FILE_MIME_TYPES.includes(contentType)) {
      throw new Error('Invalid file content type.');
    } else if (size > 10 * 1024 * 1024) {
      throw new Error('File size is too large.');
    }

    const [path, uri, headers] =
      await this.storageService.createFileUploadMetadata(
        size,
        contentType,
        hash,
      );

    const fileUploadMetadata = new FileUploadMetadata();
    fileUploadMetadata.path = path;
    fileUploadMetadata.uri = uri;
    fileUploadMetadata.headers = headers;

    return fileUploadMetadata;
  }
}
