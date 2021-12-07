import { Metadata, status } from '@grpc/grpc-js';
import { Controller } from '@nestjs/common';
import { GrpcMethod, RpcException } from '@nestjs/microservices';
import { StringValue } from 'google-protobuf/google/protobuf/wrappers_pb';
import { nanoid } from 'nanoid';
import { AccessTokenService } from 'src/access-token/access-token.service';
import { CreateStorageLinkRequest } from 'src/protobuf/socfony_pb';
import { StorageService } from './storage.service';

@Controller()
export class StorageMutation {
  constructor(
    private readonly accessTokenService: AccessTokenService,
    private readonly storageService: StorageService,
  ) {}

  @GrpcMethod()
  async create(
    request: CreateStorageLinkRequest.AsObject,
    metadata: Metadata,
  ): Promise<StringValue.AsObject> {
    // await this.accessTokenService.verifyWithMatadata(metadata);

    const key = this.createKey(request);
    const value = await this.storageService.createUploadLink({
      key,
      length: request.length,
      md5: request.md5,
    });

    return { value };
  }

  private createKey(request: CreateStorageLinkRequest.AsObject): string {
    const toaySeconds = (Date.now() / 1000 / 1000).toFixed(0);

    const name = toaySeconds + '/' + nanoid(24);
    if (typeof request.audio == 'number') {
      switch (request.audio) {
        case 0:
          return `${name}.mp3`;
        case 1:
          return `${name}.wav`;
      }
    } else if (typeof request.image == 'number') {
      switch (request.image) {
        case 0:
          return `${name}.jpg`;
        case 1:
          return `${name}.png`;
        case 2:
          return `${name}.gif`;
        case 3:
          return `${name}.webp`;
      }
    } else if (typeof request.video == 'number') {
      switch (request.video) {
        case 0:
          return `${name}.mp4`;
        case 1:
          return `${name}.webm`;
      }
    }

    throw new RpcException({
      code: status.INVALID_ARGUMENT,
      message: '没有找到正确的文件类型',
    });
  }
}
