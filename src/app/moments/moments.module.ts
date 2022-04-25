import { Module } from '@nestjs/common';
import { MomentsResolver } from './moments.resolver';

@Module({
  providers: [MomentsResolver],
})
export class MomentsModule {}
