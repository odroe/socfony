import { ArgsType, Field, IntersectionType, PickType } from '@nestjs/graphql';
import { User } from 'src/users/entities/user.entity';
import { VerificationCodeResponse } from 'src/verification-code/entities/verification-code.response';

@ArgsType()
export class LoginArguments extends IntersectionType(
  PickType(VerificationCodeResponse, <const>['context']),
  PickType(User, <const>['phone']),
  ArgsType,
) {
  @Field(() => String, { description: 'Verification code.' })
  code: string;
}
