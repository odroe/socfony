import { AccessToken } from '@prisma/client';

module '@nestjs/common' {
  interface ExecutionContext {
    accessToken: AccessToken | null;
  }
}
