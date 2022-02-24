// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Injectable } from '@nestjs/common';
import {
  AccessToken,
  OneTimePasswordType,
  Prisma,
  PrismaClient,
  User,
} from '@prisma/client';
import bcrypt = require('bcrypt');
import { nanoid } from 'nanoid';

export interface CreateAccessTokenArgs {
  account: string;
  password: string;
  usePhoneOTP: boolean;
}

@Injectable()
export class AccessTokenService {
  constructor(private readonly prisma: PrismaClient) {}

  /**
   * Create access token.
   * @param args Create access token args
   * @returns Access token
   */
  async createAccessToken(args: CreateAccessTokenArgs): Promise<AccessToken> {
    if (args.usePhoneOTP)
      return this.#createPhoneOTPAccessToken(args.account, args.password);

    return this.#createPasswordAccessToken(args.account, args.password);
  }

  /**
   * Refresh access token.
   * @param accessToken Current access token
   * @returns AccessToken
   */
  async refreshAccessToken(accessToken: AccessToken): Promise<AccessToken> {
    const [token] = await this.prisma.$transaction([
      this.#createAccessToken(accessToken.userId),
      this.prisma.accessToken.update({
        where: { token: accessToken.token },
        data: {
          refreshExpiredAt: new Date(),
          // Update expiredAt field,
          // If accessToken.expiredAt lt now, set it to accessToken.expiredAt,
          // Else set it to now + 5 minutes
          expiredAt:
            new Date() >= accessToken.expiredAt
              ? accessToken.expiredAt
              : new Date(Date.now() + 1000 * 60 * 5),
        },
      }),
    ]);

    return token;
  }

  /**
   * Using username/email/phone and password to create access token.
   * @param account Username/E-Mail/Phone
   * @param password password
   * @returns Access token
   */
  async #createPasswordAccessToken(
    account: string,
    password: string,
  ): Promise<AccessToken> {
    // Find user by account
    const user = await this.prisma.user.findFirst({
      where: {
        OR: [{ username: account }, { email: account }, { phone: account }],
      },
      rejectOnNotFound: () => new Error(`User not found`),
    });

    // Check user set password
    if (!user.password) throw new Error(`User does not set password`);

    // Check user password
    if (bcrypt.compareSync(password, user.password) !== true)
      throw new Error(`Password is incorrect`);

    // Create access token
    return this.#createAccessToken(user);
  }

  async #createPhoneOTPAccessToken(
    phone: string,
    otp: string,
  ): Promise<AccessToken> {
    // Find user by phone
    const user = await this.#phoneFindUserAutoCreate(phone);

    // Check user OTP and fetch
    const oneTimePassword = await this.prisma.oneTimePassword.findUnique({
      where: {
        type_value_otp: {
          type: OneTimePasswordType.SMS,
          value: phone,
          otp,
        },
      },
      rejectOnNotFound: () => new Error(`One-Time Password is incorrect`),
    });

    // Check OTP is expired
    if (oneTimePassword.expiredAt < new Date())
      throw new Error(`One-Time Password is expired`);

    // Create access token and delete OTP
    const [accessToken] = await this.prisma.$transaction([
      this.#createAccessToken(user),
      this.prisma.oneTimePassword.delete({
        where: {
          type_value_otp: {
            type: OneTimePasswordType.SMS,
            value: phone,
            otp,
          },
        },
      }),
    ]);

    return accessToken;
  }

  /**
   * Using a user to create access token.
   * @param user Need created access token user
   * @returns Access token client
   */
  #createAccessToken(
    user: User | string,
  ): Prisma.Prisma__AccessTokenClient<AccessToken> {
    return this.prisma.accessToken.create({
      data: {
        userId: typeof user === 'string' ? user : user.id,
        token: nanoid(128),
        // TODO: Set expiredAt
        expiredAt: new Date(Date.now() + 1000 * 60 * 60 * 24 * 7),
        refreshExpiredAt: new Date(Date.now() + 1000 * 60 * 60 * 24 * 7),
      },
    });
  }

  async #phoneFindUserAutoCreate(phone: string): Promise<User> {
    // Find user by phone
    const user = await this.prisma.user.findUnique({
      where: { phone },
      rejectOnNotFound: false,
    });

    // If user exists, return it
    if (user) return user;

    // Create user
    return this.prisma.user.create({
      data: {
        phone,
        id: nanoid(64),
      },
    });
  }
}
