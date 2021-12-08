import { ArgsType, Field, IntersectionType, PickType } from "@nestjs/graphql";
import { User } from "user/entities/user.entity";
import { VerificationCode } from "verification_code/entities/verification_code.entity";

@ArgsType()
export class CreateAccessTokenArgs extends IntersectionType(
    PickType(User, ['phone'] as const),
    PickType(VerificationCode, ['id'] as const),
    ArgsType,
) {
    @Field(() => String)
    declare phone: string;

    @Field(() => String)
    otp: string;
}
