import { Metadata, status } from '@grpc/grpc-js';
import { RpcException } from '@nestjs/microservices';
import { Prisma } from '@prisma/client';
import { AccessTokenService } from 'src/business';

export interface AuthHelperOptions {
  accessTokenService: AccessTokenService;
  metadata: Metadata;
  include?: boolean;
  refresh?: boolean;
}

export function auth({
  accessTokenService,
  metadata,
  include = false,
  refresh = false,
}: AuthHelperOptions): Promise<
  Prisma.AccessTokenGetPayload<{
    include: {
      User: typeof include;
    };
  }>
> {
  const [authentication] = metadata.get('authorization');
  const decoded =
    typeof authentication === 'string'
      ? authentication
      : authentication.toString();

  try {
    return accessTokenService.verify(decoded, { include, refresh });
  } catch (error) {
    throw new RpcException({
      code: status.UNAUTHENTICATED,
      message: error.message,
    });
  }
}
