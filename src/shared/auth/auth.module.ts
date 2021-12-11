// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
import { AuthGuard } from './auth.guard';
import { AuthMiddleware } from './auth.middleware';

@Module({
  providers: [AuthGuard, AuthMiddleware],
})
export class AuthModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    consumer.apply(AuthMiddleware).forRoutes('*');
  }
}
