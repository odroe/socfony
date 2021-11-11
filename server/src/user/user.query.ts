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

    return this.#tranformUserEntity(user);
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
