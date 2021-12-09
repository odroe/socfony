import { CanActivate, ExecutionContext, Injectable } from '@nestjs/common';
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

    return false;
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
