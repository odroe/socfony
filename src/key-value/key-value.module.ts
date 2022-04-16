import { Module } from "@nestjs/common";
import { KeyValueResolver } from "./key-value.resolver";

@Module({
  providers: [KeyValueResolver]
})
export class KeyValueModule {}
