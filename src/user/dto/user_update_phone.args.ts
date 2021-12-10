import { ArgsType, Field } from '@nestjs/graphql';

@ArgsType()
export class UserUpdatePhoneArgs {
  @Field(() => String)
  phone!: string;

  @Field(() => String)
  otp!: string;

  @Field(() => String, { nullable: true })
  currentOtp?: string;
}
