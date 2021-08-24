import { ConsoleLogger } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  await app.listen(3000);

  const url = await app.getUrl();

  const logger = new ConsoleLogger();
  logger.log(`Server listening on ${url.replace('[::1]', 'localhost')}`);
}
bootstrap();
