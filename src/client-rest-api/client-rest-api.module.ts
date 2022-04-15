import { Module } from "@nestjs/common";
import { PrismaModule } from "src/shared";

@Module({
  imports: [PrismaModule.forGlobal()],
})
export class ClientRestApiModule {}