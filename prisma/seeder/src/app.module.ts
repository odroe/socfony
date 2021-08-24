import { Module } from '@nestjs/common';
import { PrismaModule } from '@socfony/prisma';
import { AppService } from './app.service';

@Module({
  imports: [
    PrismaModule.forRoot(),
  ],
  providers: [AppService],
})
export class AppModule {}
