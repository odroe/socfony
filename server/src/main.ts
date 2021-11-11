import { NestFactory } from '@nestjs/core';
import { GrpcOptions, Transport } from '@nestjs/microservices';
import * as dotenv from 'dotenv';
import { join } from 'path';
import { AppModule } from './app.module';

// Load environment variables from .env file, where API keys and passwords are configured
dotenv.config();

// Create microservice bootstrap
async function bootstrap() {
  const app = await NestFactory.createMicroservice<GrpcOptions>(AppModule, {
    transport: Transport.GRPC,
    options: {
      package: 'odroe.socfony',
      protoPath: join(__dirname, 'socfony.proto'),
      url: process.env.GRPC_LISTEN_ADDRESS,
    },
  });

  await app.listen();

  console.log(`🚀 Server is listening on ${process.env.GRPC_LISTEN_ADDRESS}`);
}

// Start microservice
bootstrap();
