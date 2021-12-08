import { AccessToken, User } from '@prisma/client';
import { ExecutionContext } from '@nestjs/common';

declare module 'express' {
  export interface Request {
    accessToken(context: ExecutionContext): Prisma<AccessToken>;
    user(context: ExecutionContext): Prisma<User>;
  }
}
