import { Metadata, status } from '@grpc/grpc-js';
import { Controller } from '@nestjs/common';
import { GrpcMethod, RpcException } from '@nestjs/microservices';
import { PrismaClient } from '@prisma/client';
import { AccessTokenService } from 'src/access-token/access-token.service';
import {
  UserProfileEntity,
  UserProfileUpdateRequest,
} from 'src/protobuf/socfony_pb';
import { StorageService } from 'src/storage/storage.service';
import { UserProfileService } from './user-profile.service';

@Controller()
export class UserProfileMutation {
  constructor(
    private readonly accessTokenService: AccessTokenService,
    private readonly userProfileService: UserProfileService,
    private readonly prisma: PrismaClient,
    private readonly storageService: StorageService,
  ) {}

  @GrpcMethod()
  async update(
    request: UserProfileUpdateRequest.AsObject,
    metadata: Metadata,
  ): Promise<UserProfileEntity.AsObject> {
    // 获取当前认证用户 ID
    const { userId } = await this.accessTokenService.verifyWithMatadata(
      metadata,
    );

    // 获取当前用户 Profile
    const currentProfile = await this.userProfileService.resolve(userId);

    // 如果头像存在，验证头像
    if (request.avatar) {
      const exists = await this.storageService.exists(
        request.avatar,
        (data): boolean => {
          for (const key in data?.headers ?? {}) {
            if (key.toLowerCase() === 'content-type') {
              const value: string = data.headers[key];

              return value.startsWith('image') && data?.statusCode === 200;
            }
          }

          return false;
        },
      );
      if (exists[request.avatar] !== true) {
        throw new RpcException({
          code: status.INVALID_ARGUMENT,
          message: '头像文件不存在',
        });
      }
    }

    // 更新用户信息
    const profile = await this.prisma.userProfile.update({
      where: { userId: currentProfile.userId },
      data: Object.assign({}, request, {
        gender: Object.values(UserProfileEntity.Gender).includes(request.gender)
          ? this.userProfileService.grpcGender2gender(request.gender)
          : currentProfile.gender,
      }),
    });

    const entity = new UserProfileEntity();
    entity.setAvatar(profile.avatar);
    entity.setBio(profile.bio);
    entity.setBirthday(profile.birthday);
    entity.setGender(this.userProfileService.gender2grpcGender(profile.gender));
    entity.setId(profile.userId);
    entity.setName(profile.name);

    return entity.toObject();
  }
}
