// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Args, Mutation, Resolver } from '@nestjs/graphql';
import { User } from '@prisma/client';
import { parsePhoneNumber } from 'libphonenumber-js';
import { Auth } from 'shared/auth/auth.decorator';
import { VerificationCodeService } from './verification_code.service';

@Resolver(() => null)
export class VerificationCodeResolver {
  constructor(
    private readonly verificationCodeService: VerificationCodeService,
  ) {}

  @Mutation(() => Boolean)
  sendPhoneOtp(
    @Args('phone', { type: () => String, nullable: true }) phone?: string,
    @Auth.user() user?: User,
  ): boolean {
    const value = this.resolvePhone(phone, user);
    this.verificationCodeService.send(value);

    return true;
  }

  private resolvePhone(phone?: string, user?: User): string {
    if (phone) {
      return parsePhoneNumber(phone).format('E.164');
    } else if (user && user.phone) {
      return user.phone;
    }

    throw new Error('Phone number is required');
  }
}
