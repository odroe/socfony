import { Metadata } from '@grpc/grpc-js';
import { Controller } from '@nestjs/common';
import { GrpcMethod } from '@nestjs/microservices';
import { PrismaClient } from '@prisma/client';
import { AccessTokenService } from 'src/access-token/access-token.service';
import {
  UserProfileEntity,
  UserProfileUpdateRequest,
} from 'src/protobuf/socfony_pb';
import { UserProfileService } from './user-profile.service';

@Controller()
export class UserProfileMutation {
  constructor(
    private readonly accessTokenService: AccessTokenService,
    private readonly userProfileService: UserProfileService,
    private readonly prisma: PrismaClient,
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
