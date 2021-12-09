import { ExecutionContext, Injectable, NestMiddleware } from '@nestjs/common';
import { AccessToken, PrismaClient, User } from '@prisma/client';
import { Request } from 'express';
import { context2request } from './auth.helper';

@Injectable()
export class AuthMiddleware implements NestMiddleware<Request> {
  constructor(private readonly prisma: PrismaClient) {}

  use(req: Request, _res: any, next: () => void): void {
    req.accessToken = this.createAccessTokenFn();
    req.user = this.createUserFn();

    next();
  }

  private createAccessTokenFn(): (
    context: ExecutionContext,
  ) => Promise<AccessToken | null> {
    return async (context: ExecutionContext): Promise<AccessToken | null> => {
      const request = context2request(context);
      const token = request.headers.authorization;

      if (!token) {
        return null;
      }

      const result = await this.prisma.accessToken.findUnique({
        where: { token },
        rejectOnNotFound: false,
      });

      request.accessToken = async () => result;

      return result;
    };
  }

  private createUserFn(): (context: ExecutionContext) => Promise<User | null> {
    return async (context: ExecutionContext): Promise<User | null> => {
      const request = context2request(context);
      const accessToken = await this.createAccessTokenFn().call(this, context);

      if (!accessToken) {
        return null;
      }

      const result = await this.prisma.user.findUnique({
        where: { id: accessToken.userId },
        rejectOnNotFound: false,
      });

      request.user = async () => result;

      return result;
    };
  }
}
