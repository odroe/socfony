import { Module } from '@nestjs/common';
import { GlobalModule } from './global';
import { SubServicesModule } from './sub-services';

@Module({
  imports: [GlobalModule, SubServicesModule],
})
export class AppModule {}
