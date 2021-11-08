import { Module } from "@nestjs/common";
import { UserSubServiceController } from "./user.controller";

@Module({
    controllers: [UserSubServiceController],
})
export class UserSubServiceModule {}
