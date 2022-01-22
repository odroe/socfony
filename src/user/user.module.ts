import { Module } from '@nestjs/common';
import { PrismaModule } from 'src/prisma.module';
import { UserResolver } from './user.resolver';
import { UserService } from './user.service';

@Module({
  imports: [PrismaModule],
  providers: [UserService, UserResolver],
})
export class UserModule {}
