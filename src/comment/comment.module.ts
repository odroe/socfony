import { Module } from '@nestjs/common';
import { CommentResolver } from './comment.resolver';

@Module({
  providers: [CommentResolver],
})
export class CommentModule {}
