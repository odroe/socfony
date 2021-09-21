import {
  Args,
  Mutation,
  Parent,
  ResolveField,
  Resolver,
} from '@nestjs/graphql';
import {
  Prisma,
  AccessToken as AccessTokenInterface,
  PrismaClient,
} from '@prisma/client';
import { AccessTokenService } from './access-token.service';
import { SignInArgument } from './dto/sign-in.arg';
import { AccessToken } from './entites/access-token.entity';

type NeedResolveFields = keyof Prisma.AccessTokenInclude;

type AccessTokenResolveInterface = {
  [K in NeedResolveFields]: (
    ...args: any[]
  ) => AccessToken[K] | Promise<AccessToken[K]>;
};

@Resolver(() => AccessToken)
export class AccessTokenResolver implements AccessTokenResolveInterface {
  constructor(
    private readonly prisma: PrismaClient,
    private readonly accessTokenService: AccessTokenService,
  ) {}

  @ResolveField()
  user(@Parent() { user, userId }: AccessTokenInterface & AccessToken) {
    if (user) return user;

    return this.prisma.user.findUnique({
      where: { id: userId },
    });
  }

  @Mutation(() => AccessToken, {
    description: 'Sign In, create a access token',
  })
  signIn(@Args() args: SignInArgument) {
    return this.accessTokenService.signIn(args);
  }

  @Mutation(() => AccessToken, {
    description: 'Sign Up, create a access token',
  })
  signUp() {
    // TODO: implement
  }
}
