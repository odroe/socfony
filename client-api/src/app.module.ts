import { Module } from '@nestjs/common';
import { PrismaModule } from '@socfony/prisma';

@Module({
  imports: [
    PrismaModule.forRoot(),
  ],
})
export class AppModule {}
