// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import {
  CanActivate,
  ExecutionContext,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { context2request } from './auth.helper';

@Injectable()
export class AuthGuard implements CanActivate {
  constructor(private readonly reflector: Reflector) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const request = context2request(context);
    const field = this.expiredField(context);
    const accessToken = await request.accessToken(context);

    if (accessToken && accessToken[field] && accessToken[field] > new Date()) {
      return true;
    }

    throw new UnauthorizedException();
  }

  private expiredField(
    context: ExecutionContext,
  ): 'expiredAt' | 'refreshExpiredAt' {
    return (
      this.reflector.get<'expiredAt' | 'refreshExpiredAt'>(
        'type',
        context.getHandler(),
      ) ?? 'expiredAt'
    );
  }
}
