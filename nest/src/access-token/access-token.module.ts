import { Module } from "@nestjs/common";
import { PrismaModule } from "src/shared";
import { AccessTokenService } from "./access-token.service";

@Module({
    imports: [
        PrismaModule,
    ],
    providers: [AccessTokenService],
    exports: [AccessTokenService]
})
export class AccessTokenModule {}
