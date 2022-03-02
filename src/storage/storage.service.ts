import { Injectable } from '@nestjs/common';
import { COSService } from './cos';
import { nanoid } from 'nanoid';
import qs from 'qs';

@Injectable()
export class StorageService {
  constructor(private readonly cosService: COSService) {}

  /**
   * Create download url.
   * @param path COS file path.
   * @param query HTTP URL query params.
   * @returns {Promise<string>}
   */
  async createDowenloadUrl(path: string, query?: string): Promise<string> {
    return this.cosService.createDowenloadUrl(path, query);
  }

  async createFileUploadMetadata(
    size: number,
    contentType: string,
    hash: string,
  ): Promise<[string, string, string]> {
    // Create file path.
    const now = new Date();
    const path = `${now.getFullYear()}/${
      now.getMonth() + 1
    }/${now.getDate()}/${nanoid(32)}.png`;

    // Create headers.
    const headers: Record<string, any> = {
      'Content-Type': contentType,
      'Content-Length': size,
      'Content-MD5': hash,
    };
    const headersString = qs.stringify(headers);

    // Create uri.
    const uri = await this.cosService.createUploadUrl(path, headers);

    return [path, uri, headersString];
  }
}
