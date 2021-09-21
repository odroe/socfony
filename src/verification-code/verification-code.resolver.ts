import { Args, Mutation, Resolver } from '@nestjs/graphql';
import { VerificationCodeResponse } from './entities/verification-code.response';
import { SmsVerificationCodeService } from './sms-verification-code.service';
import { parsePhoneNumberWithError } from 'libphonenumber-js';

@Resolver(() => VerificationCodeResponse)
export class VerificationCodeResolver {
  constructor(private readonly sms: SmsVerificationCodeService) {}

  @Mutation(() => VerificationCodeResponse, {
    description: 'Send SMS verification code.',
  })
  sendSmsVerificationCode(
    @Args('phone', { type: () => String }) phone: string,
  ): Promise<VerificationCodeResponse> {
    const phoneNumber = parsePhoneNumberWithError(phone);
    return this.sms.send(phoneNumber.format('E.164'));
  }
}
