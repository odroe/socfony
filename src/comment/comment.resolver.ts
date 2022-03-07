import { Parent, ResolveField, Resolver } from '@nestjs/graphql';
import {
  PrismaClient,
  Comment as _Comment,
  User as _User,
  Prisma,
} from '@prisma/client';
import { User } from 'src/user/entities/user.entity';
import { Comment } from './entities/comment.entity';

@Resolver(() => Comment)
export class CommentResolver {
  constructor(private readonly prisma: PrismaClient) {}

  @ResolveField(() => User)
  user(@Parent() { userId }: _Comment): Prisma.Prisma__UserClient<_User> {
    return this.prisma.user.findUnique({
      where: { id: userId },
      rejectOnNotFound: true,
    });
  }
}
