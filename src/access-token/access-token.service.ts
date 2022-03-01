// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Injectable } from '@nestjs/common';
import {
  AccessToken,
  OneTimePasswordType,
  PrismaClient,
  User,
} from '@prisma/client';
import bcrypt = require('bcrypt');
import { nanoid } from 'nanoid';
import { parsePhoneNumber } from 'libphonenumber-js';
import { OneTimePasswordService } from 'src/one-time-password';

export interface CreateAccessTokenArgs {
  account: string;
  password: string;
  usePhoneOTP: boolean;
}

@Injectable()
export class AccessTokenService {
  constructor(
    private readonly prisma: PrismaClient,
    private readonly otpService: OneTimePasswordService,
  ) {}

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
    const token = this.#createAccessToken(accessToken.userId);
    await this.prisma.accessToken.update({
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
    });

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
    // Check phone format.
    const phoneNumber = parsePhoneNumber(phone);
    if (!phoneNumber.isValid()) throw new Error('Invalid phone number.');
    const formatedPhone = phoneNumber.format('E.164');

    // Find user by phone
    const user = await this.#phoneFindUserAutoCreate(formatedPhone);

    // Verify OTP and create delete callback.
    const deleteCallback = await this.otpService.verify(
      OneTimePasswordType.SMS,
      formatedPhone,
      otp,
    );
    await deleteCallback();

    return this.#createAccessToken(user);
  }

  /**
   * Using a user to create access token.
   * @param user Need created access token user
   * @returns Access token client
   */
  async #createAccessToken(user: User | string): Promise<AccessToken> {
    const column = await this.prisma.setting.findUnique({
      where: {
        type_key: {
          type: 'system',
          key: 'access-token',
        },
      },
      rejectOnNotFound: false,
    });
    const setting = Object.assign(
      {
        expiresIn: 60 * 60 * 24,
        refreshExpiresIn: 60 * 60 * 24 * 30,
      },
      column?.value ?? {},
    );

    return this.prisma.accessToken.create({
      data: {
        userId: typeof user === 'string' ? user : user.id,
        token: nanoid(128),
        expiredAt: new Date(Date.now() + 1000 * setting.expiresIn),
        refreshExpiredAt: new Date(
          Date.now() + 1000 * setting.refreshExpiresIn,
        ),
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
