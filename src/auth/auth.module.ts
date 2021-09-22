import { Global, MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
import { AuthGuard } from './auth.guard';
import { AuthMiddleware } from './auth.middleware';

@Global()
@Module({
  providers: [AuthGuard],
})
export class AuthModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    consumer.apply(AuthMiddleware).forRoutes('*');
  }
}
