import { ArgsType, Field } from '@nestjs/graphql';
import { UserSecurityValidatorInput } from 'src/inputs';

@ArgsType()
export class UpdateUserPhoneArgs {
  /**
   * User new phone number
   */
  @Field(() => String, {
    nullable: false,
    description: 'User new phone number',
  })
  phone: string;

  /**
   * User new phone otp.
   */
  @Field(() => String, {
    nullable: false,
    description: 'User new security one-time password',
  })
  otp: string;

  /**
   * Update validator.
   */
  @Field(() => UserSecurityValidatorInput, {
    nullable: false,
    description: 'Update validator',
  })
  validator: UserSecurityValidatorInput;
}
