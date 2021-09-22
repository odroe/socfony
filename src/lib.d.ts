import { AccessToken, User } from '@prisma/client';
import { ExecutionContext } from '@nestjs/common';

declare module 'express' {
  export interface Request {
    getAccessToken(context: ExecutionContext): Promise<AccessToken>;
    getUser(context: ExecutionContext): Promise<User>;
  }
}
