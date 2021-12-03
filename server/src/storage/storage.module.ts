import { Module } from "@nestjs/common";
import { PrismaModule } from "src/shared";

@Module({
    imports: [PrismaModule],
})
export class StorageModule {}
