import { ArgsType, Field, registerEnumType } from '@nestjs/graphql';

/**
 * Create access token args.
 */
@ArgsType()
export class CreateAccessTokenArgs {
  /**
   * Account, which will be used to create access token.
   */
  @Field(() => String, {
    nullable: false,
    description:
      'Account, which will be used to create access token.\naccount is username/id/phone,/email.',
  })
  account: string;

  /**
   * Password, which will be used to create access token.
   *
   * if [otp] is true, password is one-time password.
   * if [otp] is false, password is account password.
   */
  @Field(() => String, {
    nullable: false,
    description:
      'Password, which will be used to create access token.\npassword is account password.',
  })
  password: string;

  /**
   * if password is one-time password.
   */
  @Field(() => Boolean, {
    nullable: false,
    description: 'if password is one-time password.',
  })
  otp: boolean;
}
