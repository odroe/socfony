import { PrismaClient, VerificationCode } from '@prisma/client';
import { Injectable } from '@nestjs/common';
import { TencentcloudSmsService } from 'src/shared';
import { VerificationCodeMessage } from './verification-code.message';
import { nanoid } from 'nanoid';
import { RpcException } from '@nestjs/microservices';
import { status } from '@grpc/grpc-js';

@Injectable()
export class VerificationCodeService {
  constructor(
    private readonly tencentcloudSmsService: TencentcloudSmsService,
    private readonly prisma: PrismaClient,
  ) {}

  async send(message: VerificationCodeMessage) {
    this.#save(message);
    try {
        return await this.tencentcloudSmsService.send(message);
    } catch (error) {
        throw new RpcException(error);
    }
  }

  async verify(phone: string, code: string): Promise<VerificationCode> {
    const verificationCode = await this.#find(phone);
    if (!verificationCode) {
      throw new RpcException({
          code: status.NOT_FOUND,
          message: '验证码不存在',
      });
    } else if (verificationCode.code !== code) {
        throw new RpcException({
            code: status.UNKNOWN,
            message: '验证码不正确',
        });
    } else if (verificationCode.expiredAt < new Date()) {
        throw new RpcException({
            code: status.UNKNOWN,
            message: '验证码已过期',
        });
    }

    return verificationCode;
  }

  async delete(phone: string, code: string): Promise<void> {
    await this.prisma.$transaction([
      this.prisma.verificationCode.delete({
        where: {
          phone_code: { phone, code },
        },
      }),
      this.#deleteExpired(),
    ]);
  }

  async #find(phone: string): Promise<VerificationCode> {
    const [result] = await this.prisma.$transaction([
      this.prisma.verificationCode.findFirst({
        where: { phone },
        orderBy: { createdAt: 'desc' },
      }),
      this.#deleteExpired(),
    ]);

    return result;
  }

  async #save(message: VerificationCodeMessage) {
    await this.prisma.$transaction([
      // Create current message verification code.
      this.prisma.verificationCode.create({
        data: {
          id: nanoid(64),
          phone: message.to,
          code: message.code,
          expiredAt: message.getExpiredAt(),
        },
      }),
      // Delete expired at message.
      this.#deleteExpired(),
    ]);
  }

  #deleteExpired() {
    return this.prisma.verificationCode.deleteMany({
      where: {
        expiredAt: {
          lt: new Date(),
        },
      },
    });
  }
}
