import { Injectable } from '@nestjs/common';
import { COSService } from './cos';

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
}
