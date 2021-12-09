import { AccessToken, User } from '@prisma/client';
import { ExecutionContext } from '@nestjs/common';

declare module 'express' {
  export interface Request {
    accessToken(context: ExecutionContext): Promise<AccessToken | null>;
    user(context: ExecutionContext): Promise<User | null>;
  }
}
