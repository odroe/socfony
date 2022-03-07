import { Module } from '@nestjs/common';
import { PrismaModule } from 'src/prisma.module';

@Module({
  imports: [PrismaModule],
})
export class CommentModule {}
