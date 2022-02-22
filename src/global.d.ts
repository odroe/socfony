import { AccessToken } from '@prisma/client';

declare module '@nestjs/common' {
  interface ExecutionContext {
    accessToken: AccessToken | null;
  }
}
