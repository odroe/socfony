import { Module } from '@nestjs/common';
import { AccessTokenModule } from 'src/access-token/access-token.module';
import { PrismaModule } from 'src/shared';
import { StorageMutation } from './storage.mutation';
import { StorageQuery } from './storage.query';
import { StorageService } from './storage.service';

@Module({
  imports: [PrismaModule, AccessTokenModule],
  controllers: [StorageMutation, StorageQuery],
  providers: [StorageService],
  exports: [StorageService],
})
export class StorageModule {}
