import { Args, Mutation, registerEnumType, Resolver } from '@nestjs/graphql';
import { OneTimePasswordType } from '@prisma/client';
import { parsePhoneNumber } from 'libphonenumber-js';
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
}
