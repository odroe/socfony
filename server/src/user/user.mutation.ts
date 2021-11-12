import { Metadata, status } from '@grpc/grpc-js';
import { Controller } from '@nestjs/common';
import { GrpcMethod, RpcException } from '@nestjs/microservices';
import { PrismaClient } from '@prisma/client';
import { AccessTokenService } from 'src/access-token/access-token.service';
import { formatPhoneToE164 } from 'src/shared';
import { VerificationCodeService } from 'src/verification-code/verification-code.service';
import { UserUpdatePhoneRequest } from '../protobuf/socfony_pb';
import { UserService } from './user.service';

@Controller()
export class UserMutation {
  constructor(
    private readonly accessTokenService: AccessTokenService,
    private readonly verificationCodeService: VerificationCodeService,
    private readonly userService: UserService,
    private readonly prisma: PrismaClient,
  ) {}

  @GrpcMethod()
  async updatePhone(
    request: UserUpdatePhoneRequest.AsObject & { old_phone_code: string },
    metadata: Metadata,
  ) {
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
    const oldPhoneCode = await this.verificationCodeService.verify(
      user.phone,
      request.old_phone_code,
    );
    this.verificationCodeService.delete(user.phone, oldPhoneCode.code);

    // 验证用户新手机号码验证码
    const newPhoneCode = await this.verificationCodeService.verify(
      formatedPhoneNumber,
      request.code,
    );
    this.verificationCodeService.delete(formatedPhoneNumber, newPhoneCode.code);

    // 更新用户手机号码
    const newUser = await this.prisma.user.update({
      where: { id: user.id },
      data: { phone: formatedPhoneNumber },
    });

    // 返回用户信息
    return this.userService.createEntity(newUser).toObject();
  }
}
