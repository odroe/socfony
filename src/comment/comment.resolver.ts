import { Parent, ResolveField, Resolver } from '@nestjs/graphql';
import { PrismaClient } from '@prisma/client';
import { Comment } from './entities/comment.entity';

@Resolver(() => Comment)
export class CommentResolver {
  constructor(private readonly prisma: PrismaClient) {}

  @ResolveField()
  user(@Parent() { userId }: Comment) {
    return this.prisma.user.findUnique({
      where: { id: userId },
    });
  }
}
