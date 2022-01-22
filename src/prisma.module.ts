import { ClassProvider, Global, Module } from "@nestjs/common";

const PrismaClassProvider: ClassProvider<PrismaClient> = {
  provide: "",
  useClass:
};

@Global()
@Module({
  providers: [PrismaClassProvider],
  exports: [PrismaClassProvider],
})
export class PrismaModule {}