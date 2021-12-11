// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { ExecutionContext } from '@nestjs/common';
import { GqlExecutionContext } from '@nestjs/graphql';
import { Request } from 'express';

export function context2request(context: ExecutionContext): Request {
  const _context = GqlExecutionContext.create(context);
  if (_context.getType() === 'graphql') {
    return _context.getContext();
  }

  return context.switchToHttp().getRequest();
}
