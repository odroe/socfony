import { Module } from "@nestjs/common";
import { VerificationCodeSubServiceModule } from "./verification-code";

@Module({
    imports: [VerificationCodeSubServiceModule],
})
export class SubServicesModule {}
