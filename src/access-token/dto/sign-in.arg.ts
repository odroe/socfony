import { ArgsType, Field } from '@nestjs/graphql';

@ArgsType()
export class SignInArgument {
  @Field(() => String, { description: 'User access, E-Mail or phone number.' })
  account: string;

  @Field(() => String, { description: 'Verification code.' })
  code: string;
}
