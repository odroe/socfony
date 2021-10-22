import { Module } from "@nestjs/common";
import { HerosController } from "./heros.controller";

@Module({
    controllers: [HerosController],
})
export class HerosModule {}
