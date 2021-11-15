import { status } from '@grpc/grpc-js';
import { Controller } from '@nestjs/common';
import { GrpcMethod, RpcException } from '@nestjs/microservices';
import { PrismaClient } from '@prisma/client';
import { StringValue } from 'google-protobuf/google/protobuf/wrappers_pb';
import { UserProfileEntity } from 'src/protobuf/socfony_pb';
import { UserProfileService } from './user-profile.service';

@Controller()
export class UserProfileQuery {
  constructor(
    private readonly prisma: PrismaClient,
    private readonly userProfileService: UserProfileService,
  ) {}

  @GrpcMethod()
  async find(
    request: StringValue.AsObject,
  ): Promise<UserProfileEntity.AsObject> {
    const user = await this.prisma.user.findUnique({
      where: { id: request.value },
      rejectOnNotFound: () =>
        new RpcException({
          code: status.NOT_FOUND,
          message: '用户不存在',
        }),
    });

    const profile = await this.userProfileService.resolve(user);
    const entity = new UserProfileEntity();

    entity.setId(user.id);
    entity.setName(profile.name);
    entity.setAvatar(profile.avatar);
    entity.setGender(this.userProfileService.gender2grpcGender(profile.gender));
    entity.setBirthday(profile.birthday);
    entity.setBio(profile.bio);

    return entity.toObject();
  }
}
