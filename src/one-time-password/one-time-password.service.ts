import { Injectable } from '@nestjs/common';
import { OneTimePasswordType, Prisma, PrismaClient } from '@prisma/client';
import { OTPCommonService } from './common';
import { EmailService } from './email';
import { SMSService } from './sms';

@Injectable()
export class OneTimePasswordService {
  constructor(
    private readonly prisma: PrismaClient,
    private readonly common: OTPCommonService,
    private readonly emailService: EmailService,
    private readonly smsService: SMSService,
  ) {}

  /**
   * Save a One-Time password to database,
   * and return the generated code.
   * @param data One-Time password data.
   * @returns OTP code.
   */
  save(
    data: Pick<
      Prisma.OneTimePasswordUncheckedCreateInput,
      'expiredAt' | 'type' | 'value'
    >,
  ): Promise<string> {
    return this.common.save(data);
  }

  async sendPhoneOTP(phone: string): Promise<void> {
    return this.smsService.send(phone);
  }

  async sendEmailOTP(email: string): Promise<void> {
    return this.emailService.send(email);
  }

  async verify(type: OneTimePasswordType, value: string, otp: string) {
    const column = await this.prisma.oneTimePassword.findUnique({
      where: {
        type_value_otp: { type, value, otp },
      },
      rejectOnNotFound: () => new Error('OTP not found'),
    });

    if (column.expiredAt < new Date()) {
      throw new Error('OTP expired');
    }

    return () =>
      this.prisma.oneTimePassword.delete({
        where: {
          type_value_otp: { type, value, otp },
        },
      });
  }
}
