import { Query, Resolver } from '@nestjs/graphql';
import { AccessTokenEntity } from 'src/entities';

/**
 * Access token field resolver.
 */
@Resolver(() => AccessTokenEntity)
export class AccessTokenResolver {
  @Query(() => AccessTokenEntity)
  async getAccessToken() {}
}
