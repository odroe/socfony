import { Inject, Injectable } from '@nestjs/common';
import { ConfigType } from '@nestjs/config';
import { OneTimePassword, PrismaClient } from '@prisma/client';
import { otp } from 'src/configuration';
import { ERROR_CODE_OTP_NOT_VALID } from 'src/errorcodes';
import { IDHelper } from 'src/helpers';
import { MailerSendOptions, MailerService } from './mailer.service';
import {
  TencentCloudSMSSendOptions,
  TencentCloudSMSService,
} from './tencentcloud';

/**
 * One-time password service
 */
@Injectable()
export class OneTimePasswordService {
  constructor(
    private readonly prisma: PrismaClient,
    private readonly mailerService: MailerService,
    private readonly tencentCloudSMSService: TencentCloudSMSService,
    @Inject(otp.KEY) private readonly configure: ConfigType<typeof otp>,
  ) {}

  /**
   * Send one-time password to email
   * @param email Target
   */
  async sendToEmail(email: string): Promise<void> {
    await this.#send(email, (options: MailerSendOptions) =>
      this.mailerService.send(email, options),
    );
  }

  /**
   * Send one-time password to phone
   */
  async sendToPhone(phone: string): Promise<void> {
    await this.#send(phone, (options: TencentCloudSMSSendOptions) =>
      this.tencentCloudSMSService.send(phone, options),
    );
  }

  /**
   * compare one-time password, if not match, return error.
   * if match, return delete callback.
   */
  async compare(
    target: string,
    password: string,
  ): Promise<() => Promise<void>> {
    const otp = await this.prisma.oneTimePassword.findUnique({
      where: {
        target_password: { target, password },
      },
      rejectOnNotFound: () => new Error(ERROR_CODE_OTP_NOT_VALID),
    });

    // check if otp is expired
    if (otp.expiredAt < new Date()) throw new Error(ERROR_CODE_OTP_NOT_VALID);

    return this.#createDeleteCallback(otp);
  }

  /**
   * Create delete callback for one-time password.
   */
  #createDeleteCallback(otp: OneTimePassword): () => Promise<void> {
    return async () => {
      // Delete one-time password
      await this.prisma.oneTimePassword.delete({
        where: {
          target_password: {
            target: otp.target,
            password: otp.password,
          },
        },
      });

      // Delete all expired one-time password
      await this.prisma.oneTimePassword.deleteMany({
        where: {
          expiredAt: {
            lt: new Date(),
          },
        },
      });
    };
  }

  /**
   * Send one-time password to fn.
   * @param target Target
   * @param fn Send function
   */
  async #send(
    target: string,
    fn: (
      options: TencentCloudSMSSendOptions | MailerSendOptions,
    ) => Promise<any>,
  ) {
    // Create one-time password
    const otp = await this.prisma.oneTimePassword.create({
      data: {
        target,
        password: IDHelper.oneTimePassword(),
        expiredAt: new Date(
          Date.now() + this.configure.expiresInMinutes * 60 * 1000,
        ),
      },
    });

    // Send one-time password to target
    return await fn({
      password: otp.password,
      expiredAt: otp.expiredAt,
    });
  }
}
