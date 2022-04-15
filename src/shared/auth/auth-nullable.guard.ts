// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { CanActivate, ExecutionContext, Injectable } from '@nestjs/common';
import { GqlContextType, GqlExecutionContext } from '@nestjs/graphql';
import { AccessToken, PrismaClient } from '@prisma/client';
import { Request } from 'express';

export function getRequest(context: ExecutionContext): Request {
  if (context.getType<GqlContextType>() === 'graphql') {
    return GqlExecutionContext.create(context).getContext<Request>();
  }

  return context.switchToHttp().getRequest();
}

@Injectable()
export class AuthNullableGuard implements CanActivate {
  constructor(protected readonly prisma: PrismaClient) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    // Get the request
    const request = getRequest(context);

    // Get authorization header,
    // if it doesn't exist, return true.
    const authorization = this.getAuthorization(request);
    if (!authorization) return true;

    // Set access token in context
    const accessToken = await this.getAccessToken(authorization);
    if (accessToken != null) {
      this.checkAccessTokenSetContext(context, accessToken);
    }

    return true;
  }

  private getAuthorization(request: Request): string | undefined {
    return request.header('authorization');
  }

  private async getAccessToken(
    authorization: string,
  ): Promise<AccessToken | null> {
    return this.prisma.accessToken.findUnique({
      where: { token: authorization },
      rejectOnNotFound: false,
    });
  }

  private checkAccessTokenSetContext(
    context: ExecutionContext,
    accessToken: AccessToken,
  ): void {
    if (accessToken.expiredAt > new Date()) {
      const request = getRequest(context);
      request.accessToken = accessToken;
    }
  }
}
