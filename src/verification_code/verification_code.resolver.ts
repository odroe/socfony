import { Args, Mutation, Resolver } from "@nestjs/graphql";
import { VerificationCode } from "./entities/verification_code.entity";

@Resolver(() => VerificationCode)
export class VerificationCodeResolver {
    @Mutation(() => VerificationCode)
    async sendPhoneOtp(
        @Args('phone', { type: () => String, nullable: true }) phone?: string,
    ) {
        //
    }
}
