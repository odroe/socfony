import { Args, Mutation, registerEnumType, Resolver } from '@nestjs/graphql';
import { AccessToken, OneTimePasswordType, PrismaClient } from '@prisma/client';
import { parsePhoneNumber } from 'libphonenumber-js';
import { Auth } from 'src/auth';
import { OneTimePasswordService } from './one-time-password.service';

registerEnumType(OneTimePasswordType, { name: 'OneTimePasswordType' });

@Resolver()
export class OneTimePasswordResolver {
  constructor(
    private readonly otpService: OneTimePasswordService,
    private readonly prisma: PrismaClient,
  ) {}

  @Mutation(() => Boolean)
  sendOTP(
    @Args({ name: 'type', type: () => OneTimePasswordType })
    type: OneTimePasswordType,
    @Args({ name: 'value', type: () => String }) value: string,
  ) {
    switch (type) {
      case OneTimePasswordType.EMAIL:
        this.otpService.sendEmailOTP(value);
        break;
      case OneTimePasswordType.SMS:
        // Check if phone number is valid.
        const phone = parsePhoneNumber(value);
        if (!phone.isValid()) {
          throw new Error('Invalid phone number.');
        }

        this.otpService.sendPhoneOTP(phone.format('E.164'));
        break;
    }

    return true;
  }

  @Mutation(() => Boolean)
  @Auth.must()
  async sendMeOtp(
    @Args({ name: 'type', type: () => OneTimePasswordType })
    type: OneTimePasswordType,
    @Auth.accessToken() { userId }: AccessToken,
  ) {
    const user = await this.prisma.user.findUnique({
      select: { email: true, phone: true },
      where: { id: userId },
      rejectOnNotFound: true,
    });

    switch (type) {
      case OneTimePasswordType.EMAIL:
        if (user.email) {
          this.otpService.sendEmailOTP(user.email);
          break;
        }
        throw new Error('User has no email.');

      case OneTimePasswordType.SMS:
        if (user.phone) {
          this.otpService.sendPhoneOTP(user.phone);
          break;
        }
        throw new Error('User has no phone number.');
    }

    return true;
  }
}
