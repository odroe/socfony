import { Global, Module } from '@nestjs/common';
import { AuthModule } from './auth/auth.module';
import { PrismaModule } from './prisma.module';

const modules = [PrismaModule, AuthModule];

@Global()
@Module({
  imports: modules,
  exports: modules,
})
export class SharedModule {}
