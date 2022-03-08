import {
  Args,
  ID,
  Parent,
  Query,
  ResolveField,
  Resolver,
} from '@nestjs/graphql';
import {
  PrismaClient,
  Comment as _Comment,
  User as _User,
  Moment as _Moment,
  Prisma,
  PrismaPromise,
} from '@prisma/client';
import { User } from 'src/user/entities/user.entity';
import { CommentFindManyArgs } from './dto/comment-find-many.args';
import { Comment } from './entities/comment.entity';
import { Commentable } from './entities/commentable.union';

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

  @ResolveField(() => User)
  user(@Parent() { userId }: _Comment): Prisma.Prisma__UserClient<_User> {
    return this.prisma.user.findUnique({
      where: { id: userId },
      rejectOnNotFound: true,
    });
  }

  @ResolveField(() => Commentable)
  commentable(
    @Parent() comment: _Comment,
  ): Prisma.Prisma__MomentClient<_Moment> {
    return this.prisma.moment.findUnique({
      where: { id: comment.momentId! },
      rejectOnNotFound: true,
    });
  }
}
