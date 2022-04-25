import { Field, ObjectType } from '@nestjs/graphql';

@ObjectType({ description: 'User security entity' })
export class UserSecurityEntity {
  /**
   * User phone number
   */
  @Field(() => String, { nullable: true, description: 'User phone number' })
  phone?: string;

  /**
   * User email
   */
  @Field(() => String, { nullable: true, description: 'User email' })
  email?: string;

  /**
   * User password
   */
  @Field(() => Boolean, { nullable: false, description: 'User password' })
  password: boolean;
}
