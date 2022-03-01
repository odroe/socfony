import { ArgsType, Field } from '@nestjs/graphql';

@ArgsType()
export class UpdateUserPhoneArgs {
  @Field(() => String)
  phone: string;

  @Field(() => String)
  otp: string;

  @Field(() => String, { nullable: true })
  oldPhoneOTP?: string;
}
