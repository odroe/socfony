import { Controller } from '@nestjs/common';
import { GrpcMethod } from '@nestjs/microservices';
import { StringValue } from 'google-protobuf/google/protobuf/wrappers_pb';
import { GetStorageLinkRequest } from 'src/protobuf/socfony_pb';
import { StorageService } from './storage.service';

@Controller()
export class StorageQuery {
  constructor(private readonly storageService: StorageService) {}

  @GrpcMethod()
  async get(
    request: GetStorageLinkRequest.AsObject,
  ): Promise<StringValue.AsObject> {
    const value = await this.storageService.createDownloadLink(request);

    return { value };
  }
}
