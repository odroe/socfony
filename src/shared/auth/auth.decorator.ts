import {
  applyDecorators,
  createParamDecorator,
  ExecutionContext,
  SetMetadata,
  UseGuards,
} from '@nestjs/common';
import { AuthGuard } from './auth.guard';
import { context2request } from './auth.helper';

export const Auth = (refresh: boolean = false) =>
  applyDecorators(
    SetMetadata('type', refresh ? 'refreshExpiredAt' : 'expiredAt'),
    UseGuards(AuthGuard),
  );

Auth.accessToken = createParamDecorator((_data, context: ExecutionContext) =>
  context2request(context).accessToken(context),
);

Auth.user = createParamDecorator((_data, context: ExecutionContext) =>
  context2request(context).user(context),
);

Auth.refresh = () => Auth(true);
