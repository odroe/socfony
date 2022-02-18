import {
  CanActivate,
  ExecutionContext,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { PrismaClient } from '@prisma/client';
import { AuthNullableGuard } from './auth-nullable.guard';

@Injectable()
export class AuthRefreshGuard extends AuthNullableGuard implements CanActivate {
  constructor(prisma: PrismaClient) {
    super(prisma);
  }

  async canActivate(context: ExecutionContext): Promise<boolean> {
    await super.canActivate(context);

    const accessToken = context.accessToken;
    if (!accessToken || accessToken.refreshExpiredAt < new Date()) {
      throw new UnauthorizedException('Unauthorized');
    }

    return true;
  }
}
