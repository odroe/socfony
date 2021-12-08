import { Args, Mutation, Resolver } from '@nestjs/graphql';
import { CreateAccessTokenArgs } from './dto/create_access_token.args';
import { AccessToken } from './entities/access_token.entity';

@Resolver(() => AccessToken)
export class AccessTokenResolver {
  @Mutation(() => AccessToken)
  async createAccessToken(
    @Args({ type: () => CreateAccessTokenArgs }) args: CreateAccessTokenArgs,
  ) {
    console.log(args);
  }
}
