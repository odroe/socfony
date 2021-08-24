import { Module } from '@nestjs/common';
import { EventEmitterModule } from '@nestjs/event-emitter';
import { PrismaModule } from '@socfony/prisma';
import { AppService } from './app.service';
import * as listeners from './listeners';

@Module({
  imports: [PrismaModule.forRoot(), EventEmitterModule.forRoot()],
  providers: [...Object.values(listeners), AppService],
})
export class AppModule {}
