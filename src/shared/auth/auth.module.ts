// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Module } from '@nestjs/common';
import { AuthNullableGuard } from './auth-nullable.guard';
import { AuthRefreshGuard } from './auth-refresh.guard';
import { AuthGuard } from './auth.guard';

@Module({
  providers: [AuthNullableGuard, AuthGuard, AuthRefreshGuard],
})
export class AuthModule {
  static forRoot() {
    return {
      module: AuthModule,
    };
  }
}
