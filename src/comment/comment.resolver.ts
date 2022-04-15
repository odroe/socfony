import { Args, ID, Query, Resolver } from '@nestjs/graphql';
import {
  PrismaClient,
  Comment as _Comment,
  User as _User,
  Moment as _Moment,
  Prisma,
  PrismaPromise,
} from '@prisma/client';

import { CommentFindManyArgs } from './dto/comment-find-many.args';
import { Comment } from './entities/comment.entity';

@Resolver(() => Comment)
export class CommentResolver {
  constructor(private readonly prisma: PrismaClient) {}

  @Query(() => Comment)
  comment(
    @Args({ name: 'id', type: () => ID }) id: string,
  ): Prisma.Prisma__CommentClient<_Comment> {
    return this.prisma.comment.findUnique({
      where: { id },
      rejectOnNotFound: true,
    });
  }

  @Query(() => [Comment])
  comments(
    @Args({ type: () => CommentFindManyArgs }) args: CommentFindManyArgs,
  ): PrismaPromise<_Comment[]> {
    return this.prisma.comment.findMany(args);
  }
}
