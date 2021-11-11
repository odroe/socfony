import { Module } from '@nestjs/common';
import { PrismaModule } from 'src/shared';
import { UserQuery } from './user.query';

@Module({
  imports: [PrismaModule],
  controllers: [UserQuery],
})
export class UserModule {}
