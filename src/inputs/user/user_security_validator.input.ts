import { Field, InputType, registerEnumType } from '@nestjs/graphql';

export enum UserSecurityFieldsEnum {
  phone = 'phone',
  email = 'email',
  password = 'password',
}

registerEnumType(UserSecurityFieldsEnum, {
  name: 'UserSecurityFields',
});

@InputType({ description: 'User securoty validator input' })
export class UserSecurityValidatorInput {
  /**
   * Validate field.
   */
  @Field(() => UserSecurityFieldsEnum, {
    nullable: false,
    description: 'Validate field',
  })
  field: UserSecurityFieldsEnum;

  /**
   * Validate value.
   */
  @Field(() => String, { nullable: false, description: 'Validate value' })
  value: string;
}
