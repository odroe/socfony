import { ArgsType, Field, registerEnumType } from '@nestjs/graphql';

export enum UserSecurityFields {
  PHONE = 'phone',
  EMAIL = 'email',
  PASSWORD = 'password',
}
registerEnumType(UserSecurityFields, {
  name: 'UserSecurityFields',
  description: 'User security fields.',
});

@ArgsType()
export class UpdateUserSecurityArgs {
  @Field(() => UserSecurityFields, {
    description: 'User security field to update.',
  })
  field: UserSecurityFields;

  @Field(() => String, { description: 'User security field value.' })
  value: string;

  @Field(() => UserSecurityFields, {
    description: 'User security field to verify.',
  })
  verifyField: UserSecurityFields;

  @Field(() => String, { description: 'User security field value to verify.' })
  verifyValue: string;

  @Field(() => String, { description: 'Phone/E-Mail OTP', nullable: true })
  otp?: string;
}
