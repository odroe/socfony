import { Metadata, status } from '@grpc/grpc-js';
import { Controller } from '@nestjs/common';
import { GrpcMethod, RpcException } from '@nestjs/microservices';
import { PrismaClient, VerificationCode } from '@prisma/client';
import { Empty } from 'google-protobuf/google/protobuf/empty_pb';
import { StringValue } from 'google-protobuf/google/protobuf/wrappers_pb';
import { AccessTokenService } from 'src/access-token/access-token.service';
import { formatPhoneToE164 } from 'src/shared';
import { StorageService } from 'src/storage/storage.service';
import { VerificationCodeService } from 'src/verification-code/verification-code.service';
import { UserEntity, UserUpdatePhoneRequest } from '../protobuf/socfony_pb';
import { UserService } from './user.service';

@Controller()
export class UserMutation {
  constructor(
    private readonly accessTokenService: AccessTokenService,
    private readonly verificationCodeService: VerificationCodeService,
    private readonly userService: UserService,
    private readonly prisma: PrismaClient,
    private readonly storageService: StorageService,
  ) {}

  @GrpcMethod()
  async updatePhone(
    request: UserUpdatePhoneRequest.AsObject & { old_phone_code: string },
    metadata: Metadata,
  ): Promise<UserEntity.AsObject> {
    // 格式化手机号码
    const formatedPhoneNumber = formatPhoneToE164(request.phone);

    // 验证认证信息并获取认证用户
    const { User: user } = await this.accessTokenService.verifyWithMatadata(
      metadata,
      {
        include: true,
      },
    );

    // 判断当前手机号码是否和原手机号一致
    if (user.phone === formatedPhoneNumber) {
      throw new RpcException({
        code: status.INVALID_ARGUMENT,
        message: '你的手机号不能与原手机号一致',
      });
    }

    // 判断当前手机号码是否已经被注册
    const existUser = await this.prisma.user.findFirst({
      where: {
        phone: formatedPhoneNumber,
        id: { not: user.id },
      },
      rejectOnNotFound: false,
    });
    if (existUser) {
      throw new RpcException({
        code: status.INVALID_ARGUMENT,
        message: '该手机号已被使用',
      });
    }

    // 验证久手机号码验证码
    let oldPhoneCode: VerificationCode;
    if (user.phone) {
      oldPhoneCode = await this.verificationCodeService.verify(
        user.phone,
        request.old_phone_code ?? request.oldPhoneCode,
      );
    }

    // 验证用户新手机号码验证码
    const newPhoneCode = await this.verificationCodeService.verify(
      formatedPhoneNumber,
      request.code,
    );

    // 更新用户手机号码
    const newUser = await this.prisma.user.update({
      where: { id: user.id },
      data: { phone: formatedPhoneNumber },
    });

    // 删除验证码
    this.verificationCodeService.delete(newPhoneCode.phone, newPhoneCode.code);
    if (oldPhoneCode) {
      this.verificationCodeService.delete(
        oldPhoneCode.phone,
        oldPhoneCode.code,
      );
    }

    // 返回用户信息
    return this.userService.createEntity(newUser).toObject();
  }

  @GrpcMethod()
  async updateName(
    request: StringValue.AsObject,
    metadata: Metadata,
  ): Promise<UserEntity.AsObject> {
    // 获取验证的用户
    const { userId } = await this.accessTokenService.verifyWithMatadata(
      metadata,
    );

    // 获取排除当前用户的用户信息
    const exists = await this.prisma.user.findFirst({
      where: {
        name: request.value,
        id: { not: userId },
      },
      rejectOnNotFound: false,
    });

    // 判断用户是否存在
    if (exists) {
      throw new RpcException({
        code: status.INVALID_ARGUMENT,
        message: '该用户名已被使用',
      });
    }

    // 更新用户名
    const newUser = await this.prisma.user.update({
      where: { id: userId },
      data: { name: request.value },
    });

    // 返回用户信息
    return this.userService.createEntity(newUser).toObject();
  }

  @GrpcMethod()
  async updateAvatar(
    request: StringValue.AsObject,
    metadata: Metadata,
  ): Promise<Empty.AsObject> {
    // 获取验证的用户
    const { userId } = await this.accessTokenService.verifyWithMatadata(
      metadata,
    );

    // 验证头像文件是否存在
    const exists = await this.storageService.exists(
      request.value,
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
    if (exists[request.value] !== true) {
      throw new RpcException({
        code: status.INVALID_ARGUMENT,
        message: '头像文件不存在',
      });
    }

    // 更新用户头像
    await this.prisma.userProfile.update({
      where: { userId },
      data: { avatar: request.value },
    });

    return new Empty().toObject();
  }
}
