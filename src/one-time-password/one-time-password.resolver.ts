import { Args, Mutation, Resolver } from '@nestjs/graphql';
import { OneTimePasswordService } from './one-time-password.service';

@Resolver()
export class OneTimePasswordResolver {
  constructor(private readonly otpService: OneTimePasswordService) {}

  @Mutation(() => Boolean)
  sendPhoneOTP(@Args({ name: 'phone', type: () => String }) phone: string) {
    this.otpService.sendPhoneOTP(phone);

    return true;
  }

  @Mutation(() => Boolean)
  sendEmailOTP(@Args({ name: 'email', type: () => String }) email: string) {
    this.otpService.sendEmailOTP(email);

    return true;
  }
}
