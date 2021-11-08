import { Module } from '@nestjs/common';
import * as SubServices from './sub-services';

@Module({
  imports: Object.values(SubServices),
})
export class SubServicesModule {}
