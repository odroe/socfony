import {
  ExecutionContext,
  UseGuards,
  createParamDecorator,
} from '@nestjs/common';
import { AuthGuard } from './auth.guard';
import { context2request } from './auth.helpers';

export const Auth = () => UseGuards(AuthGuard);

export const GetAccessToken = createParamDecorator(
  (_data, context: ExecutionContext) => {
    const request = context2request(context);

    return request.getAccessToken(context);
  },
);

export const GetUser = createParamDecorator(
  (_data, context: ExecutionContext) => {
    const request = context2request(context);

    return request.getUser(context);
  },
);
