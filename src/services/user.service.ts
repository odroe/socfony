import { Injectable } from '@nestjs/common';
import { Prisma, PrismaClient } from '@prisma/client';
import { ERROR_CODE_USER_NOT_FOUND } from 'src/errorcodes';
import { GraphQLException } from 'src/graphql.exception';

@Injectable()
export class UserService {
  constructor(private readonly prisma: PrismaClient) {}

  findUniqueOrThrow(where: Prisma.UserWhereUniqueInput) {
    return this.prisma.user.findUnique({
      where,
      rejectOnNotFound: () => new GraphQLException(ERROR_CODE_USER_NOT_FOUND),
    });
  }
}
