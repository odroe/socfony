import { NestApplication, NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create<NestApplication>(AppModule);

  await app.listen(3000);

  const url = (await app.getUrl()).replace('[::1]', '127.0.0.1');
  console.log(`Server running on ${url}`);
}
bootstrap();
