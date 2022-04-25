import { Args, Mutation, Query, Resolver } from '@nestjs/graphql';
import { CreateAccessTokenArgs } from 'src/args';
import { AccessTokenEntity } from 'src/entities';
import { AccessTokenService } from 'src/services';

/**
 * Access token mutation.
 */
@Resolver(() => AccessTokenEntity)
export class AccessTokenMutation {
  constructor(private readonly accessTokenService: AccessTokenService) {}

  /**
   * Create a new access token.
   */
  @Mutation(() => AccessTokenEntity, {
    name: 'createAccessToken',
    description: 'Create a new access token.',
    nullable: false,
  })
  async createAccessToken(
    @Args({ type: () => CreateAccessTokenArgs }) args: CreateAccessTokenArgs,
  ) {
    return this.accessTokenService.createAccessToken(
      args.account,
      args.password,
      args.otp,
    );
  }

  @Query(() => AccessTokenEntity)
  async getAccessToken() {}
}
