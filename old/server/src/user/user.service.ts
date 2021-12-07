import { Injectable } from '@nestjs/common';
import { User } from '@prisma/client';
import { Timestamp } from 'google-protobuf/google/protobuf/timestamp_pb';
import { UserEntity } from 'src/protobuf/socfony_pb';
import { phoneNumberDesensitization } from 'src/shared';

@Injectable()
export class UserService {
  createEntity(user: User): UserEntity {
    const entity = new UserEntity();
    entity.setId(user.id);
    entity.setName(user.name);
    entity.setPhone(phoneNumberDesensitization(user.phone));
    entity.setCreatedAt(Timestamp.fromDate(user.createdAt));

    return entity;
  }
}
