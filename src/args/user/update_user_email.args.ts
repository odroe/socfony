import { ArgsType, Field, OmitType } from '@nestjs/graphql';
import { UpdateUserPhoneArgs } from './update_user_phone.args';

@ArgsType()
export class UpdateUserEmailArgs extends OmitType(
  UpdateUserPhoneArgs,
  ['phone'] as const,
  ArgsType,
) {
  /**
   * User new email.
   */
  @Field(() => String, { nullable: false, description: 'User new email' })
  email: string;
}
