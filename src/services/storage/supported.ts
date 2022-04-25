import {
  SupportedImageStorageMetadata,
  SupportedStorageMetadata,
  SupportedVideoStorageMetadata,
} from './metadata';

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
