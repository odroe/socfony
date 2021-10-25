import { Module } from "@nestjs/common";
import { VerificationCodeSubServiceController } from "./verification-code.controller";
import { VerificationCodeModule } from '../../business';

@Module({
    imports: [VerificationCodeModule],
    controllers: [VerificationCodeSubServiceController],
})
export class VerificationCodeSubServiceModule {}
