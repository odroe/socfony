import { Mutation, Resolver } from '@nestjs/graphql';
import { Auth } from 'src/auth';
import { TencentCloudSTSClient } from './tencent_cloud_sts_service';
import { FederationToken } from './entities/federation_token';
import { AccessToken } from '@prisma/client';

@Resolver(() => FederationToken)
export class StorageResolver {
  constructor(private readonly sts: TencentCloudSTSClient) {}

  @Mutation(() => FederationToken)
  @Auth.nullable()
  createDownloadFederationToken(@Auth.accessToken() accessToken?: AccessToken) {
    return this.sts.createDownloadFederationToken(accessToken?.userId);
  }

  @Mutation(() => FederationToken)
  @Auth.must()
  createUploadFederationToken() {
    return this.sts.createUploadFederationToken();
  }
}
