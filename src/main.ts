import { Logger } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  await app.listen(3000);

  // Get the app running URL
  const url = await app.getUrl();
  Logger.log(`🚀  Server ready at ${url.replace('[::1]', '127.0.0.1')}`, 'Bootstrap');
}

bootstrap();
