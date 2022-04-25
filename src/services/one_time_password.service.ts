import { Injectable } from "@nestjs/common";
import { OneTimePassword, PrismaClient } from "@prisma/client";
import { ERROR_CODE_OTP_NOT_VALID } from "src/errorcodes";

/**
 * One-time password service
 */
@Injectable()
export class OneTimePasswordService {
  constructor(
    private readonly prisma: PrismaClient,
  ) {}

  /**
   * compare one-time password, if not match, return error.
   * if match, return delete callback.
   */
  async compare(target: string, password: string): Promise<() => Promise<void>> {
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
          }
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
}