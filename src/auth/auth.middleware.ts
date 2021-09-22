import { ExecutionContext, Injectable, NestMiddleware } from '@nestjs/common';
import { AccessToken, PrismaClient, User } from '@prisma/client';
import { Request } from 'express';
import { context2request } from './auth.helpers';

@Injectable()
export class AuthMiddleware implements NestMiddleware<Request> {
  constructor(private readonly prisma: PrismaClient) {}

  use(request: Request, _res: any, next: () => void) {
    request.getAccessToken = (context: ExecutionContext) =>
      this.#getAccessToken(context);
    request.getUser = (context: ExecutionContext) => this.#getUser(context);

    next();
  }

  async #getUser(context: ExecutionContext): Promise<User> {
    const accessToken = await this.#getAccessToken(context);
    if (!accessToken) {
      return undefined;
    }

    return await this.prisma.user.findUnique({
      where: { id: accessToken.userId },
      rejectOnNotFound: false,
    });
  }

  async #getAccessToken(context: ExecutionContext): Promise<AccessToken> {
    const request = context2request(context);
    const authorization = request.header('authorization');
    if (!authorization) {
      return undefined;
    }

    const accessToken = await this.prisma.accessToken.findUnique({
      where: { token: authorization },
      rejectOnNotFound: false,
    });

    if (!accessToken) {
      return undefined;
    } else if (accessToken.expiredAt < new Date()) {
      return undefined;
    }

    return accessToken;
  }
}
