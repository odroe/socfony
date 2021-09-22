import { Field, GraphQLISODateTime, Int, ObjectType } from '@nestjs/graphql';

@ObjectType()
export class VerificationCodeResponse {
  @Field(() => String, { description: 'Verification code context ID.' })
  context: string;

  @Field(() => GraphQLISODateTime, { description: 'Expired at.' })
  expiredAt: Date;

  @Field(() => Int, { description: 'Next timing second cycle.' })
  period: number;
}