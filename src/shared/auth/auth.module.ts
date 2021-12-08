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
