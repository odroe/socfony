// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { ExecutionContext } from '@nestjs/common';
import { createParamDecorator, UseGuards } from '@nestjs/common';
import { AccessToken } from '@prisma/client';
import { AuthNullableGuard } from './auth-nullable.guard';
import { AuthRefreshGuard } from './auth-refresh.guard';
import { AuthGuard } from './auth.guard';

export namespace Auth {
  export const nullable = () => UseGuards(AuthNullableGuard);
  export const refresh = () => UseGuards(AuthRefreshGuard);
  export const must = () => UseGuards(AuthGuard);

  export const accessToken = createParamDecorator(
    (_data, context: ExecutionContext): AccessToken | null =>
      context.accessToken,
  );
}
