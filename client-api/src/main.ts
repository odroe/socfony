import { Logger } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';
import { NestExpressApplication } from '@nestjs/platform-express';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create<NestExpressApplication>(AppModule);
  await app.listen(3000);

  const url = await app.getUrl();

  new Logger().log(`🎉 Server on ${url.replace('[::1]', 'localhost')}`);
}

bootstrap();
