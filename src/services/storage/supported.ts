import {
  SupportedImageStorageMetadata,
  SupportedStorageMetadata,
  SupportedVideoStorageMetadata,
} from './metadata';

export const SupportedImageStorageMetadatas: SupportedImageStorageMetadata[] = [
  new SupportedImageStorageMetadata('image/jpeg', 'jpg'),
  new SupportedImageStorageMetadata('image/png', 'png'),
  new SupportedImageStorageMetadata('image/gif', 'gif'),
  new SupportedImageStorageMetadata('image/webp', 'webp'),
];

export const SupportedVideoStorageMetadatas: SupportedVideoStorageMetadata[] = [
  new SupportedVideoStorageMetadata('video/mp4', 'mp4'),
  new SupportedVideoStorageMetadata('video/webm', 'webm'),
];

export const supportedStorageMetadatas: SupportedStorageMetadata[] = [
  ...SupportedImageStorageMetadatas,
  ...SupportedVideoStorageMetadatas,
];
