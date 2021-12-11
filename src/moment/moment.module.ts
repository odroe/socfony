import { Module } from '@nestjs/common';
import { MomentResolver } from './moment.resolver';

@Module({
  providers: [MomentResolver],
})
export class MomentModule {}
