import { Inject, Injectable } from '@nestjs/common';
import { ConfigType } from '@nestjs/config';
import { OneTimePassword, PrismaClient } from '@prisma/client';
import { otp } from 'src/configuration';
import { ERROR_CODE_OTP_NOT_VALID, ERROR_CODE_OTP_SEND_LIMIT_EXCEEDED } from 'src/errorcodes';
import { GraphQLException } from 'src/graphql.exception';
import { IDHelper } from 'src/helpers';
import { SendOneTimePasswordTencendCloudSimpleEmailOptions, SendOneTimePasswordTencentCloudShortMessageOptions, TencentCloudShortMessageService, TencentCloudSimpleEmailService } from './tencentcloud';

/**
 * One-time password service
 */
@Injectable()
export class OneTimePasswordService {
  constructor(
    private readonly prisma: PrismaClient,
    private readonly sms: TencentCloudShortMessageService,
    private readonly ses: TencentCloudSimpleEmailService,
    @Inject(otp.KEY) private readonly configure: ConfigType<typeof otp>,
  ) {}

  /**
   * Send one-time password to email
   * @param email Target
   */
  async sendToEmail(email: string): Promise<void> {
    await this.#send(email, (options: SendOneTimePasswordTencendCloudSimpleEmailOptions) =>
      this.ses.sendOneTimePassword(email, options),
    );
  }

  /**
   * Send one-time password to phone
   */
  async sendToPhone(phone: string): Promise<void> {
    await this.#send(phone, (options: SendOneTimePasswordTencentCloudShortMessageOptions) =>
      this.sms.sendOneTimePassword(phone, options),
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
      rejectOnNotFound: () => new GraphQLException(ERROR_CODE_OTP_NOT_VALID),
    });

    // check if otp is expired
    if (otp.expiredAt < new Date()) throw new GraphQLException(ERROR_CODE_OTP_NOT_VALID);

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
      options: SendOneTimePasswordTencentCloudShortMessageOptions | SendOneTimePasswordTencendCloudSimpleEmailOptions,
    ) => Promise<any>,
  ) {
    // 统计当前 target 24 小时内发送的次数，如果超过限制，则抛出异常
    const count = await this.prisma.oneTimePassword.count({
      where: {
        target,
        createdAt: {
          gte: new Date(Date.now() - 24 * 60 * 60 * 1000),
        },
      },
    });
    if (count >= this.configure.limit) throw new GraphQLException(ERROR_CODE_OTP_SEND_LIMIT_EXCEEDED);

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
      expiresIn: this.configure.expiresInMinutes,
    });
  }
}
