import { Module } from '@nestjs/common';
import { HerosModule } from './heros.module';

@Module({
  imports: [HerosModule],
})
export class AppModule {}
