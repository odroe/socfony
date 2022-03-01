import { Args, Mutation, registerEnumType, Resolver } from '@nestjs/graphql';
import { OneTimePasswordType } from '@prisma/client';
import { OneTimePasswordService } from './one-time-password.service';

registerEnumType(OneTimePasswordType, { name: 'OneTimePasswordType' });

@Resolver()
export class OneTimePasswordResolver {
  constructor(private readonly otpService: OneTimePasswordService) {}

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
        this.otpService.sendPhoneOTP(value);
        break;
    }

    return true;
  }
}
