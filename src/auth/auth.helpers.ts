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
