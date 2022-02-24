import { Injectable } from '@nestjs/common';
import { Prisma, PrismaClient } from '@prisma/client';
import { customAlphabet } from 'nanoid';
import { SMSService } from './sms';

@Injectable()
export class OneTimePasswordService {
  constructor(
    private readonly prisma: PrismaClient,
    private readonly smsService: SMSService,
  ) {}

  /**
   * Save a One-Time password to database,
   * and return the generated code.
   * @param data One-Time password data.
   * @returns OTP code.
   */
  async save(
    data: Pick<
      Prisma.OneTimePasswordUncheckedCreateInput,
      'expiredAt' | 'type' | 'value'
    >,
  ): Promise<string> {
    // Create a OTP value.
    const otp = customAlphabet('1234567890')(6);

    // Save to database.
    await this.prisma.oneTimePassword.create({
      data: { ...data, otp },
    });

    return otp;
  }

  async sendPhoneOTP(phone: string): Promise<void> {
    return this.smsService.send(phone);
  }
}
