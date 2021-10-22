import { NestFactory } from '@nestjs/core';
import { GrpcOptions, Transport } from '@nestjs/microservices';
import { join } from 'path';
import { AppModule } from './app.module';

async function bootstrap() {
  const url = '0.0.0.0:3000';
  const app = await NestFactory.createMicroservice<GrpcOptions>(AppModule, {
    transport: Transport.GRPC,
    options: {
      package: 'com.odroe.socfony',
      protoPath: join(__dirname, '../protos/socfony.proto'),
      url,
    },
  });

  await app.listen();

  console.log(`🚀 Server is listening on ${url}`);
}

bootstrap();

