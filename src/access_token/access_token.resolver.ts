import { PrismaClient } from '.prisma/client';
import {
  Args,
  Mutation,
  Parent,
  ResolveField,
  Resolver,
} from '@nestjs/graphql';
import { parsePhoneNumber } from 'libphonenumber-js';
import { Auth } from 'shared/auth/auth.decorator';
import { User } from 'user/entities/user.entity';
import { VerificationCodeService } from 'verification_code/verification_code.service';
import { AccessTokenService } from './access_token.service';
import { CreateAccessTokenArgs } from './dto/create_access_token.args';
import { AccessToken } from './entities/access_token.entity';

@Resolver(() => AccessToken)
export class AccessTokenResolver {
  constructor(
    private readonly prisma: PrismaClient,
    private readonly accessTokenService: AccessTokenService,
    private readonly verificationCodeService: VerificationCodeService,
  ) {}

  @Mutation(() => AccessToken)
  async createAccessToken(
    @Args({ type: () => CreateAccessTokenArgs }) args: CreateAccessTokenArgs,
  ) {
    const { phone, otp } = args;
    const validatedPhone = this.validatePhone(phone);
    const done = await this.validateOtp(validatedPhone, otp);
    const result = await this.accessTokenService.authRegister(validatedPhone);

    done();

    return result;
  }

  @Mutation(() => AccessToken)
  @Auth.refresh()
  async refreshAccessToken(@Auth.accessToken() accessToken: AccessToken) {
    return this.accessTokenService.refresh(accessToken);
  }

  @Mutation(() => Boolean)
  @Auth.refresh()
  async revokeAccessToken(@Auth.accessToken() accessToken: AccessToken) {
    this.accessTokenService.delete(accessToken);

    return true;
  }

  @ResolveField(() => User)
  user(@Parent() { userId }: AccessToken) {
    return this.prisma.user.findUnique({ where: { id: userId } });
  }

  private validatePhone(phone: string): string {
    return parsePhoneNumber(phone).format('E.164');
  }

  private async validateOtp(phone: string, otp: string): Promise<() => void> {
    const isValid = await this.verificationCodeService.verify(phone, otp);
    if (!isValid) {
      throw new Error('Invalid OTP');
    }

    return () => {
      this.verificationCodeService.delete(phone, otp);
    };
  }
}
