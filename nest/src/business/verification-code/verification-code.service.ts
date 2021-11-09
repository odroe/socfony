import { PrismaClient, VerificationCode } from '@prisma/client';
import { Injectable } from '@nestjs/common';
import { TencentcloudSmsService } from 'src/shared';
import { VerificationCodeMessage } from './verification-code.message';
import { nanoid } from 'nanoid';

@Injectable()
export class VerificationCodeService {
  constructor(
    private readonly tencentcloudSmsService: TencentcloudSmsService,
    private readonly prisma: PrismaClient,
  ) {}

  async send(message: VerificationCodeMessage) {
    this.#save(message);
    return this.tencentcloudSmsService.send(message);
  }

  async verify(phone: string, code: string): Promise<VerificationCode> {
    const verificationCode = await this.#find(phone);
    if (!verificationCode) {
      throw new Error('Verification code not found.');
    } else if (verificationCode.code !== code) {
      throw new Error('Verification code is incorrect.');
    } else if (verificationCode.expiredAt < new Date()) {
      throw new Error('Verification code is expired.');
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
