import { Args, Mutation, Resolver } from '@nestjs/graphql';
import { AccessToken } from '@prisma/client';
import { CreateAccessTokenArgs } from 'src/args';
import { Auth } from 'src/auth';
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

  /**
   * Delete a access token.
   */
  @Mutation(() => Boolean, {
    name: 'deleteAccessToken',
    description: 'Delete a access token.',
    nullable: false,
  })
  @Auth.nullable()
  async deleteAccessToken(
    @Auth.accessToken() accessToken?: AccessToken
  ) {
    if (accessToken && accessToken.token) {
      await this.accessTokenService.deleteAccessToken(accessToken.token);
    }

    return true;
  }

  /**
   * Refresh a access token.
   */
  @Mutation(() => AccessTokenEntity, {
    name: 'refreshAccessToken',
    description: 'Refresh a access token.',
    nullable: false,
  })
  @Auth.refresh()
  async refreshAccessToken(@Auth.accessToken() { token }: AccessToken) {
    return this.accessTokenService.refreshAccessToken(token);
  }
}
