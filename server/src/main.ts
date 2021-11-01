import { NestFactory } from '@nestjs/core';
import { GrpcOptions, Transport } from '@nestjs/microservices';
import * as dotenv from 'dotenv';
import * as path from 'path';
import { AppModule } from './app.module';

// Load environment variables from .env file, where API keys and passwords are configured
dotenv.config();

// compatible @vercel/ncc
const protoFilePath = path.join(__dirname, '../../protos/socfony.proto');

// Create microservice bootstrap
async function bootstrap() {
  const app = await NestFactory.createMicroservice<GrpcOptions>(AppModule, {
    transport: Transport.GRPC,
    options: {
      package: 'odroe.socfony',
      protoPath: protoFilePath,
      url: process.env.GRPC_LISTEN_ADDRESS,
    },
  });

  await app.listen();

  console.log(`🚀 Server is listening on ${process.env.GRPC_LISTEN_ADDRESS}`);
}

// Start microservice
bootstrap();
