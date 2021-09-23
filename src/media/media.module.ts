import { Module } from '@nestjs/common';
import { StorageBoxModule } from 'src/storage-box';
import { MediaResolver } from './media.resolver';
import { MediaService } from './media.service';

@Module({
  imports: [StorageBoxModule.box('vendor'), StorageBoxModule.box('cos')],
  providers: [MediaService, MediaResolver],
  exports: [MediaService],
})
export class MediaModule {}
