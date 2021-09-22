import {
  CanActivate,
  ExecutionContext,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { context2request } from './auth.helpers';

@Injectable()
export class AuthGuard implements CanActivate {
  async canActivate(context: ExecutionContext): Promise<boolean> {
    const request = context2request(context);
    const accessToken = await request.getAccessToken(context);

    if (!accessToken) {
      throw new UnauthorizedException('Unauthorized');
    }

    return true;
  }
}
