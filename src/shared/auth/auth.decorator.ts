// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

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
