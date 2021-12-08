import { Module } from "@nestjs/common";
import { VerificationCodeResolver } from "./verification_code.resolver";

@Module({
    providers: [VerificationCodeResolver],
})
export class VerificationCodeModule {}
