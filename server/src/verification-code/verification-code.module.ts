import { Module } from "@nestjs/common";
import { PrismaModule, TencentcloudSmsModule } from "src/shared";
import { VerificationCodeMutation } from "./verification-code.mutation";
import { VerificationCodeService } from "./verification-code.service";

@Module({
    imports: [PrismaModule, TencentcloudSmsModule],
    controllers: [VerificationCodeMutation],
    providers: [VerificationCodeService],
})
export class VerificationCodeModule {}
