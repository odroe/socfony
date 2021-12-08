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

    if (accessToken && accessToken[field] && accessToken[field] > Date.now()) {
      return true;
    }

    return false;
  }

  private expiredField(
    context: ExecutionContext,
  ): 'exporedAt' | 'refreshExpiredAt' {
    return (
      this.reflector.get<'exporedAt' | 'refreshExpiredAt'>(
        'type',
        context.getHandler(),
      ) ?? 'exporedAt'
    );
  }
}
