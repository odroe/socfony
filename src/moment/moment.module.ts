import { Module } from '@nestjs/common';
import { MediaModule } from 'media/media.module';
import { MomentResolver } from './moment.resolver';

@Module({
  imports: [MediaModule],
  providers: [MomentResolver],
})
export class MomentModule {}
