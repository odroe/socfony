// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import {
  CanActivate,
  ExecutionContext,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { PrismaClient } from '@prisma/client';
import { ERROR_CODE_UNATHORIZED } from 'src/errorcodes';
import { AuthNullableGuard, getRequest } from './auth-nullable.guard';

@Injectable()
export class AuthGuard extends AuthNullableGuard implements CanActivate {
  constructor(prisma: PrismaClient) {
    super(prisma);
  }

  async canActivate(context: ExecutionContext): Promise<boolean> {
    await super.canActivate(context);

    const { accessToken } = getRequest(context);
    if (accessToken == null) {
      throw new UnauthorizedException(ERROR_CODE_UNATHORIZED);
    }

    return true;
  }
}
