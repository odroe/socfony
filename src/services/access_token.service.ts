import { Inject, Injectable } from '@nestjs/common';
import { ConfigType } from '@nestjs/config';
import { PrismaClient } from '@prisma/client';
import dayjs = require('dayjs');
import { auth } from 'src/configuration';
import {
  ERROR_CODE_UNATHORIZED,
  ERROR_CODE_USER_NOT_FOUND,
  ERROR_CODE_USER_NOT_SET_PASSWORD,
  ERROR_CODE_USER_PASSWORD_NOT_MATCH,
} from 'src/errorcodes';
import { GraphQLException } from 'src/graphql.exception';
import { EmailHelper, IDHelper, PhoneNumberHelper } from 'src/helpers';
import { PasswordHelper } from 'src/helpers/password';
import { OneTimePasswordService } from './one_time_password.service';

@Injectable()
export class AccessTokenService {
  constructor(
    private readonly prisma: PrismaClient,
    private readonly oneTimePasswordService: OneTimePasswordService,
    @Inject(auth.KEY)
    private readonly config: ConfigType<typeof auth>,
  ) {}

  /**
   * Create a new access token.
   */
  async createAccessToken(
    account: string,
    password: string,
    otp: boolean = false,
  ) {
    if (otp == true) {
      return this.#createAccessTokenByOTP(
        account.toLocaleLowerCase(),
        password,
      );
    }

    return this.#createAccessTokenByPassword(
      account.toLocaleLowerCase(),
      password,
    );
  }

  /**
   * Delete a access token.
   */
  async deleteAccessToken(token: string) {
    await this.prisma.accessToken.delete({
      where: { token },
    });
  }

  /**
   * Refresh a access token.
   */
  async refreshAccessToken(token: string) {
    const accessToken = await this.prisma.accessToken.findUnique({
      where: { token },
      rejectOnNotFound: () => new GraphQLException(ERROR_CODE_UNATHORIZED),
    });

    // If access token is expired, return error
    if (accessToken.refreshExpiredAt < new Date())
      throw new GraphQLException(ERROR_CODE_UNATHORIZED);

    // Update access token refresh expired is now,
    // and expired is now + 5 minutes
    await this.prisma.accessToken.update({
      where: { token },
      data: {
        expiredAt: dayjs().add(5, 'minute').toDate(),
        refreshExpiredAt: new Date(),
      },
    });

    return this.#createAccessTokenByUserId(accessToken.ownerId);
  }

  /**
   * Create a new access token by password.
   */
  async #createAccessTokenByPassword(account: string, password: string) {
    const { id, password: hash } = await this.#findUserOrThrow(account);

    // If user not set password, return error
    if (!hash) throw new GraphQLException(ERROR_CODE_USER_NOT_SET_PASSWORD);

    // Compare password, if not match, return error
    if (!PasswordHelper.compare(password, hash))
      throw new GraphQLException(ERROR_CODE_USER_PASSWORD_NOT_MATCH);

    return this.#createAccessTokenByUserId(id);
  }

  /**
   * Create a new access token by OTP.
   */
  async #createAccessTokenByOTP(account: string, otp: string) {
    const { id } = await this.#findPhoneUserOrCrrate(account);
    const deleteCallback = await this.oneTimePasswordService.compare(
      account,
      otp,
    );

    // Delete one-time password
    deleteCallback();

    return this.#createAccessTokenByUserId(id);
  }

  /**
   * find phone user or create a new user.
   *
   * If account is phone number, create user by phone number.
   * if account is email, call [#findUserOrThrow]
   */
  async #findPhoneUserOrCrrate(account: string) {
    if (EmailHelper.is(account)) {
      return this.#findUserOrThrow(account);
    }

    const phone = PhoneNumberHelper.e164(account);
    const user = await this.prisma.user.findUnique({
      where: { phone },
      rejectOnNotFound: false,
    });
    if (user) return user;

    // If user not found, create new user
    return this.prisma.user.create({
      data: { phone, id: IDHelper.primary() },
    });
  }

  /**
   * Find user or throw error.
   */
  #findUserOrThrow(account: string) {
    return this.prisma.user.findFirst({
      where: {
        OR: [
          { id: account },
          { email: account },
          { phone: account },
          { username: account },
        ],
      },
      rejectOnNotFound: () => new GraphQLException(ERROR_CODE_USER_NOT_FOUND),
    });
  }

  /**
   * Create a new access token by user id.
   */
  #createAccessTokenByUserId(userId: string) {
    // Delete all expired access tokens.
    this.#deleteExpiredAccessTokens();

    return this.prisma.accessToken.create({
      data: {
        ownerId: userId,
        token: IDHelper.token(),
        expiredAt: dayjs()
          .add(this.config.access.value, this.config.access.unit)
          .toDate(),
        refreshExpiredAt: dayjs()
          .add(this.config.refresh.value, this.config.refresh.unit)
          .toDate(),
      },
    });
  }

  /**
   * Delete all expired access tokens.
   */
  async #deleteExpiredAccessTokens() {
    await this.prisma.accessToken.deleteMany({
      where: {
        expiredAt: { lt: new Date() },
        refreshExpiredAt: { lt: new Date() },
      },
    });
  }
}
