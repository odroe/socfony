export abstract class SupportedStorageMetadata {
  constructor(
    public readonly mimeType: string,
    public readonly extension: string,
  ) {}
}
