import { ERROR_CODE_STORAGE_UNSUPPORTED_MIME_TYPE } from 'src/errorcodes';
import { GraphQLException } from 'src/graphql.exception';
import { SupportedStorageMetadata } from './metadata';
import { supportedStorageMetadatas } from './supported';

export function finder(mimeType: string): SupportedStorageMetadata {
  const metadata: SupportedStorageMetadata | undefined =
    supportedStorageMetadatas.find(
      (supportedStorageMetadata) =>
        supportedStorageMetadata.mimeType.toLocaleLowerCase() ===
        mimeType.toLocaleLowerCase(),
    );

  if (!(metadata instanceof SupportedStorageMetadata)) {
    throw new GraphQLException(ERROR_CODE_STORAGE_UNSUPPORTED_MIME_TYPE);
  }

  return metadata;
}
