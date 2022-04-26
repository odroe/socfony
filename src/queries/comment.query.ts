import { Args, Query, Resolver } from '@nestjs/graphql';
import { PrismaClient } from '@prisma/client';
import { CommentFindManyArgs } from 'src/args';
import { CommentEntity } from 'src/entities';
import { ERROR_CODE_COMMENT_NOT_FOUND } from 'src/errorcodes';
import { GraphQLException } from 'src/graphql.exception';
import { CommentWhereInput, CommentWhereUniqueInput } from 'src/inputs';

@Resolver(() => CommentEntity)
export class CommentQuery {
  constructor(private readonly prisma: PrismaClient) {}

  /**
   * Comment find one
   */
  @Query(() => CommentEntity, {
    name: 'commentFindOne',
    description: 'Comment find one',
    nullable: false,
  })
  async findOne(
    @Args('where', { type: () => CommentWhereInput }) where: CommentWhereInput,
  ) {
    return this.prisma.comment.findFirst({
      where,
      rejectOnNotFound: () => new GraphQLException(ERROR_CODE_COMMENT_NOT_FOUND),
    });
  }

  /**
   * Comment find many
   */
  @Query(() => [CommentEntity], {
    name: 'commentFindMany',
    description: 'Comment find many',
    nullable: false,
  })
  async findMany(
    @Args({ type: () => CommentFindManyArgs }) args: CommentFindManyArgs,
  ) {
    return this.prisma.comment.findMany(args);
  }
}
