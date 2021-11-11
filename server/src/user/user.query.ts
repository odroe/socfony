import { status } from '@grpc/grpc-js';
import { Controller } from '@nestjs/common';
import { GrpcMethod, RpcException } from '@nestjs/microservices';
import { PrismaClient, User } from '@prisma/client';
import { Timestamp } from 'google-protobuf/google/protobuf/timestamp_pb';
import {
  UserEntity,
  UserFindOneRequest,
  UserSearchRequest,
} from 'src/protobuf/socfony_pb';
import { phoneNumberDesensitization } from 'src/shared';

@Controller()
export class UserQuery {
  constructor(private readonly prisma: PrismaClient) {}

  @GrpcMethod()
  async findOne(
    where: UserFindOneRequest.AsObject,
  ): Promise<UserEntity.AsObject> {
    const user = await this.prisma.user.findUnique({
      where,
      rejectOnNotFound: () =>
        new RpcException({
          code: status.NOT_FOUND,
          message: '用户未找到',
        }),
    });

    return this.#tranformUserEntity(user);
  }

  @GrpcMethod()
  async findMany(request: { conditions: UserFindOneRequest.AsObject[] }) {
    if (!request.conditions?.length) {
      return this.#tranformUserEntityList([]);
    } else if (request.conditions.length > 60) {
      throw new RpcException({
        code: status.INVALID_ARGUMENT,
        message: '查询条件不能超过60个',
      });
    }

    const users = await this.prisma.user.findMany({
      where: { OR: request.conditions },
    });

    return this.#tranformUserEntityList(users);
  }

  @GrpcMethod()
  async search(request: UserSearchRequest.AsObject) {
    if (!request.keyword) {
      return this.#tranformUserEntityList([]);
    } else if (request.limit && request.limit > 60) {
      throw new RpcException({
        code: status.INVALID_ARGUMENT,
        message: '获取的条数不能超过60个',
      });
    } else if (
      typeof request.limit === 'number' &&
      (request.limit < 1 || request.limit === 0)
    ) {
      throw new RpcException({
        code: status.INVALID_ARGUMENT,
        message: '获取的条数不得少于1个',
      });
    } else if (request.offset && request.offset < 0) {
      throw new RpcException({
        code: status.INVALID_ARGUMENT,
        message: '数据偏移量不能小于0',
      });
    }

    const users = await this.prisma.user.findMany({
      where: {
        OR: [{ name: { contains: request.keyword } }],
      },
      take: request.limit || 15,
      skip: request.offset ?? 0,
    });

    return this.#tranformUserEntityList(users);
  }

  async #tranformUserEntityList(
    users: User[],
  ): Promise<{ users: UserEntity.AsObject[] }> {
    const entities = await Promise.all(
      users.map(async (user) => await this.#tranformUserEntity(user)),
    );

    return { users: entities };
  }

  async #tranformUserEntity(user: User): Promise<UserEntity.AsObject> {
    const entity = new UserEntity();
    entity.setId(user.id);
    entity.setName(user.name);
    entity.setPhone(phoneNumberDesensitization(user.phone));
    entity.setCreatedAt(Timestamp.fromDate(user.createdAt));

    return entity.toObject();
  }
}
