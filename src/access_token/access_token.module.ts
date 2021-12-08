import { Module } from "@nestjs/common";
import { AccessTokenResolver } from "./access_token.resolver";

@Module({
    providers: [AccessTokenResolver],
})
export class AccessTokenModule {}
