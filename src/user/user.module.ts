// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Module } from '@nestjs/common';
import { VerificationCodeModule } from 'verification_code/verification_code.module';
import { UserProfileModule } from './profile/user_profile.module';
import { UserResolver } from './user.resolver';

@Module({
  imports: [VerificationCodeModule, UserProfileModule],
  providers: [UserResolver],
})
export class UserModule {}
