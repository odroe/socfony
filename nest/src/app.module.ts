import { Module } from '@nestjs/common';
import { SubServicesModule } from './sub-services';

@Module({
  imports: [SubServicesModule],
})
export class AppModule {}
