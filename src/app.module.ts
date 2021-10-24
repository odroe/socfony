import { Module } from '@nestjs/common';
import { GlobalModule } from './global/global.module';
import { HerosModule } from './heros.module';

@Module({
  imports: [GlobalModule, HerosModule],
})
export class AppModule {}
