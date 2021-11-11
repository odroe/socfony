import { status } from '@grpc/grpc-js';
import { Controller } from '@nestjs/common';
import { GrpcMethod, RpcException } from '@nestjs/microservices';
import { PrismaClient, User } from '@prisma/client';
import { Timestamp } from 'google-protobuf/google/protobuf/timestamp_pb';
import { UserEntity, UserFindOneRequest } from 'src/protobuf/socfony_pb';
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

    return (await this.#tranformUserEntity(user)).toObject();
  }

  @GrpcMethod()
  async findMany(request: { conditions: UserFindOneRequest.AsObject[] }) {
    if (!request.conditions?.length) {
      return { users: [] };
    } else if (request.conditions.length > 60) {
      throw new RpcException({
        code: status.INVALID_ARGUMENT,
        message: '查询条件不能超过60个',
      });
    }

    const data = await this.prisma.user.findMany({
      where: { OR: request.conditions },
    });

    const users = await Promise.all(
      data.map(async (user) =>
        (await this.#tranformUserEntity(user)).toObject(),
      ),
    );

    return { users };
  }

  async #tranformUserEntity(user: User): Promise<UserEntity> {
    const entity = new UserEntity();
    entity.setId(user.id);
    entity.setName(user.name);
    entity.setPhone(phoneNumberDesensitization(user.phone));
    entity.setCreatedAt(Timestamp.fromDate(user.createdAt));

    return entity;
  }
}
