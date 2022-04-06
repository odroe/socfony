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
import { AuthNullableGuard, getRequest } from './auth-nullable.guard';

@Injectable()
export class AuthRefreshGuard extends AuthNullableGuard implements CanActivate {
  constructor(prisma: PrismaClient) {
    super(prisma);
  }

  async canActivate(context: ExecutionContext): Promise<boolean> {
    await super.canActivate(context);

    const accessToken = getRequest(context).accessToken;
    if (!accessToken || accessToken.refreshExpiredAt < new Date()) {
      throw new UnauthorizedException('Unauthorized');
    }

    return true;
  }
}
