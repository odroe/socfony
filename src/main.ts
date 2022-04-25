// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Logger } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app';

async function bootstrap() {
  // Create the Nest application
  const app = await NestFactory.create(AppModule);

  // Get app listening on the configured port
  const port: number =
    app.get(ConfigService).get<number>('server.port')!;

  // Start the application
  await app.listen(port);

  // Get the app running URL
  const url = await app.getUrl();
  Logger.log(
    `🚀  Server ready at ${url.replace('[::1]', '127.0.0.1')}`,
    'Bootstrap',
  );
}

bootstrap();
