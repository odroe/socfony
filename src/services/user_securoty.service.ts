import { Injectable } from '@nestjs/common';
import { PrismaClient } from '@prisma/client';
import {
  ERROR_CODE_EMAIL_NOT_VALID,
  ERROR_CODE_USER_EMAIL_ALREADY_EXISTS,
  ERROR_CODE_USER_NOT_SET_EMAIL,
  ERROR_CODE_USER_NOT_SET_PHONE,
  ERROR_CODE_USER_PASSWORD_NOT_MATCH,
  ERROR_CODE_USER_PHONE_ALREADY_EXISTS,
} from 'src/errorcodes';
import { GraphQLException } from 'src/graphql.exception';
import {
  EmailHelper,
  PasswordHelper,
  PhoneNumberHelper,
  UtilHelpers,
} from 'src/helpers';
import { UserSecurityFieldsEnum } from 'src/inputs';
import { OneTimePasswordService } from './one_time_password.service';
import { UserService } from './user.service';

@Injectable()
export class UserSecurityService {
  constructor(
    private readonly prisma: PrismaClient,
    private readonly oneTimePasswordService: OneTimePasswordService,
    private readonly userService: UserService,
  ) {}

  /**
   * Update user phone.
   */
  async updateUserPhone(
    userId: string,
    { phone, otp }: { phone: string; otp: string },
    { field, value }: { field: UserSecurityFieldsEnum; value: string },
  ) {
    // Phone number to E.164 format
    const e164 = PhoneNumberHelper.e164(phone);

    /// Check User Phone number already exists.
    const exists = await this.prisma.user.findUnique({
      where: { phone: e164 },
      rejectOnNotFound: false,
      select: { id: true },
    });
    if (exists && exists.id !== userId) {
      throw new GraphQLException(ERROR_CODE_USER_PHONE_ALREADY_EXISTS);
    }

    // Validate phone one-time password and get delete callback.
    const otpDeleteCallback = await this.oneTimePasswordService.compare(
      e164,
      otp,
    );

    // Run validator and get callback.
    const validatorCallback = await this.#validator(userId, field, value);

    // Run all callback.
    Promise.all([otpDeleteCallback, validatorCallback]);

    // Update user phone.
    return this.prisma.user.update({
      where: { id: userId },
      data: { phone: e164 },
    });
  }

  /**
   * Update user email.
   */
  async updateUserEmail(
    userId: string,
    { email, otp }: { email: string; otp: string },
    { field, value }: { field: UserSecurityFieldsEnum; value: string },
  ) {
    // Check email is valid.
    if (EmailHelper.isNot(email)) {
      throw new GraphQLException(ERROR_CODE_EMAIL_NOT_VALID);
    }

    // Check email user exists.
    const exists = await this.prisma.user.findUnique({
      where: { email },
      select: { id: true },
      rejectOnNotFound: false,
    });
    if (exists && exists.id !== userId) {
      throw new GraphQLException(ERROR_CODE_USER_EMAIL_ALREADY_EXISTS);
    }

    // Validate phone one-time password and get delete callback.
    const otpDeleteCallback = await this.oneTimePasswordService.compare(
      email,
      otp,
    );

    // Run validator and get callback.
    const validatorCallback = await this.#validator(userId, field, value);

    // Run all callback.
    Promise.all([otpDeleteCallback, validatorCallback]);

    // Update user phone.
    return this.prisma.user.update({
      where: { id: userId },
      data: { email: email.toLocaleLowerCase() },
    });
  }

  /**
   * Update user password.
   */
  async updateUserPassword(
    userId: string,
    password: string,
    { field, value }: { field: UserSecurityFieldsEnum; value: string },
  ) {
    // Run validateor
    const callback = await this.#validator(userId, field, value);
    callback();

    return this.prisma.user.update({
      where: { id: userId },
      data: {
        password: PasswordHelper.hash(password),
      },
    });
  }

  /**
   * User security validator.
   */
  async #validator(
    userId: string,
    field: UserSecurityFieldsEnum,
    value: string,
  ): Promise<() => Promise<void>> {
    const { [field]: security } = await this.userService.findUniqueOrThrow({
      id: userId,
    });

    // If field is password
    if (field === UserSecurityFieldsEnum.password) {
      if (
        UtilHelpers.isEmpty(security) ||
        PasswordHelper.compare(value, security!) === false
      ) {
        throw new GraphQLException(ERROR_CODE_USER_PASSWORD_NOT_MATCH);
      }

      return async () => {};

      // If securoty is empty
    } else if (UtilHelpers.isEmpty(security)) {
      throw new Error(
        field === UserSecurityFieldsEnum.email
          ? ERROR_CODE_USER_NOT_SET_EMAIL
          : ERROR_CODE_USER_NOT_SET_PHONE,
      );
    }

    // Validate otp and get delete callback.
    return this.oneTimePasswordService.compare(security!, value);
  }
}
