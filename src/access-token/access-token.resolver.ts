import {
  Args,
  Mutation,
  Parent,
  ResolveField,
  Resolver,
} from '@nestjs/graphql';
import {
  AccessToken as AccessTokenInterface,
  Prisma,
  PrismaClient,
} from '@prisma/client';
import { parsePhoneNumberWithError } from 'libphonenumber-js';
import { AccessTokenService } from './access-token.service';
import { LoginArguments } from './dto/login.args';
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
  login(@Args() args: LoginArguments) {
    return this.accessTokenService.login({
      ...args,
      phone: parsePhoneNumberWithError(args.phone).format('E.164'),
    });
  }
}
