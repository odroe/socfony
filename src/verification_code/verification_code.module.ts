// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Module } from '@nestjs/common';
import { VerificationCodeResolver } from './verification_code.resolver';
import { VerificationCodeService } from './verification_code.service';

@Module({
  providers: [VerificationCodeResolver, VerificationCodeService],
  exports: [VerificationCodeService],
})
export class VerificationCodeModule {}
