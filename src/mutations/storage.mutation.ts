import { Args, Int, Mutation, Resolver } from '@nestjs/graphql';
import { AccessToken, PrismaClient } from '@prisma/client';
import QueryString = require('qs');
import { Auth } from 'src/auth';
import { StoragePutUrlMetadataEntity } from 'src/entities';
import { IDHelper } from 'src/helpers';
import {
  StorageService,
  SupportedStorageMetadata,
  supportedStorageMetadataFinder,
} from 'src/services';

@Resolver(() => StoragePutUrlMetadataEntity)
export class StorageMutation {
  constructor(
    private readonly storageService: StorageService,
    private readonly prisma: PrismaClient,
  ) {}

  /**
   * Create a put object request signed url.
   */
  @Mutation(() => StoragePutUrlMetadataEntity, {
    name: 'createPutObjectSignedUrl',
    description: 'Create a put object request signed url',
    nullable: false,
  })
  @Auth.must()
  async createPutObjectSignedUrl(
    @Auth.accessToken() { ownerId }: AccessToken,
    @Args('md5', {
      type: () => String,
      description: 'File md5 hash hex (32 bytes)',
    })
    md5: string,
    @Args('size', { type: () => Int, description: 'File size in bytes' })
    size: number,
    @Args('mimeType', { type: () => String, description: 'File MIME type' })
    mimeType: string,
  ): Promise<StoragePutUrlMetadataEntity> {
    // Find supported storage metadata
    const supportedStorageMetadata: SupportedStorageMetadata =
      supportedStorageMetadataFinder(mimeType);

    // 32 bytes md5 hex converted to 16 bytes binary, then base64 encoded
    const encodedMD5: string = Buffer.from(md5, 'hex').toString('base64');

    // Build headers
    const headers: Record<string, any> = {
      'Content-MD5': encodedMD5,
      'Content-Type': mimeType,
      'Content-Length': size,
    };

    // Object basename
    const basename: string = IDHelper.primary();

    // YYYY: Year, Full length
    // MM: Month, 2 digits
    // DD: Day, 2 digits
    const now: Date = new Date();
    const year: string = now.getFullYear().toString();
    const month: string = (now.getMonth() + 1).toString().padStart(2, '0');
    const day: string = now.getDate().toString().padStart(2, '0');
    const location: string = `${year}/${month}/${day}/${basename}.${supportedStorageMetadata.extension}`;

    // Get signed URL
    const url: string = await this.storageService.createObjectURLBylocation(
      location,
      {
        headers,
        method: 'PUT',
        expiresIn: 60 * 60 * 6, // 6 hours
      },
    );

    // Create storage
    const { id } = await this.prisma.storage.create({
      select: { id: true },
      data: {
        id: basename,
        isUsed: false,
        location,
        ownerId,
      },
    });

    return { id, url, headers: QueryString.stringify(headers) };
  }
}
