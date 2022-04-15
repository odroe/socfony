// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { AccessToken as _AccessToken } from '@prisma/client';
import { Args, Mutation, Resolver } from '@nestjs/graphql';
import { AccessTokenService } from './access-token.service';
import { AccessToken } from './entities/access-token.entity';
import { Auth } from 'src/shared/auth';

@Resolver(() => AccessToken)
export class AccessTokenResolver {
  constructor(private readonly accessTokenService: AccessTokenService) {}

  /**
   * Using password to login
   * @param account username/email/phone
   * @param password User password
   * @returns AccessToken
   */
  @Mutation(() => AccessToken, { description: 'Using password to login' })
  async login(
    @Args({
      type: () => String,
      name: 'account',
      description: 'username/phone/email',
    })
    account: string,
    @Args({
      type: () => String,
      name: 'password',
      description: 'User password',
    })
    password: string,
    @Args({
      name: 'usePhoneOTP',
      type: () => Boolean,
      description: 'Whether to use phone OTP',
      defaultValue: false,
    })
    usePhoneOTP: boolean,
  ): Promise<_AccessToken> {
    return this.accessTokenService.createAccessToken({
      account,
      password,
      usePhoneOTP,
    });
  }

  /**
   * Refresh Access token.
   * @param accessToken Current access token
   * @returns AccessToken
   */
  @Auth.refresh()
  @Mutation(() => AccessToken, { description: 'Refresh access token' })
  async refreshAccessToken(@Auth.accessToken() accessToken: _AccessToken) {
    return this.accessTokenService.refreshAccessToken(accessToken);
  }

  /**
   * Logout, Delete access token.
   */

  @Auth.nullable()
  @Mutation(() => Boolean, { description: 'Logout' })
  async logout(@Auth.accessToken() accessToken?: _AccessToken) {
    if (accessToken) {
      await this.accessTokenService.deleteAccessToken(accessToken);
    }
    return true;
  }
}
