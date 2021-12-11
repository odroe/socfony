// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Module } from '@nestjs/common';
import { VerificationCodeModule } from 'verification_code/verification_code.module';
import { AccessTokenResolver } from './access_token.resolver';
import { AccessTokenService } from './access_token.service';

@Module({
  imports: [VerificationCodeModule],
  providers: [AccessTokenResolver, AccessTokenService],
  exports: [AccessTokenService],
})
export class AccessTokenModule {}
