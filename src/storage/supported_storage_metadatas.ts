export abstract class SupportedStorageMetadata {
  constructor(
    public readonly mimeType: string,
    public readonly extension: string,
  ) {}
}

export class SupportedImageStorageMetadata extends SupportedStorageMetadata {}
export class SupportedVideoStorageMetadata extends SupportedStorageMetadata {}

export const supportedStorageMetadatas: SupportedStorageMetadata[] = [
  // Image metadatas
  new SupportedImageStorageMetadata('image/jpeg', 'jpg'),
  new SupportedImageStorageMetadata('image/png', 'png'),
  new SupportedImageStorageMetadata('image/gif', 'gif'),
  new SupportedImageStorageMetadata('image/webp', 'webp'),

  // Video metadatas
  new SupportedVideoStorageMetadata('video/mp4', 'mp4'),
  new SupportedVideoStorageMetadata('video/webm', 'webm'),
];

export function findSupportedStorageMetadata(
  mimeType: string,
): SupportedStorageMetadata {
  const metadata: SupportedStorageMetadata | undefined =
    supportedStorageMetadatas.find(
      (supportedStorageMetadata) =>
        supportedStorageMetadata.mimeType.toLocaleLowerCase() ===
        mimeType.toLocaleLowerCase(),
    );

  if (!(metadata instanceof SupportedStorageMetadata)) {
    throw new Error(`Unsupported MIME type: ${mimeType}`);
  }

  return metadata;
}
