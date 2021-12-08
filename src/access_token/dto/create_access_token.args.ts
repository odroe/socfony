import { ArgsType, Field, PickType } from '@nestjs/graphql';
import { User } from 'user/entities/user.entity';

@ArgsType()
export class CreateAccessTokenArgs extends PickType(
  User,
  ['phone'] as const,
  ArgsType,
) {
  @Field(() => String)
  declare phone: string;

  @Field(() => String)
  otp: string;
}
