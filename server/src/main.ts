import { Logger } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

/// Create a main loggger
const logger = new Logger('main');

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  await app.listen(3000);

  logger.log('Application listening on port 3000');
}

bootstrap();
