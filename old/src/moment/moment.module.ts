import { Module } from '@nestjs/common';
import { AccessTokenModule } from 'src/access-token/access-token.module';
import { PrismaModule } from 'src/shared';
import { StorageModule } from 'src/storage/storage.module';
import { MomentMutation } from './moment.mutation';

@Module({
  imports: [PrismaModule, StorageModule, AccessTokenModule],
  controllers: [MomentMutation],
})
export class MomentModule {}
