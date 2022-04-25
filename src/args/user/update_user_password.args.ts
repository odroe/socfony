import { ArgsType, Field, PickType } from '@nestjs/graphql';
import { UpdateUserPhoneArgs } from './update_user_phone.args';

@ArgsType()
export class UpdateUserPasswordArgs extends PickType(
  UpdateUserPhoneArgs,
  ['validator'] as const,
  ArgsType,
) {
  /**
   * User new password.
   */
  @Field(() => String, { nullable: false, description: 'User new password' })
  password: string;
}
