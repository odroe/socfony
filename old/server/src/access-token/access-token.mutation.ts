import { Metadata, status } from '@grpc/grpc-js';
import { Controller } from '@nestjs/common';
import { GrpcMethod, RpcException } from '@nestjs/microservices';
import { PrismaClient, User } from '@prisma/client';
import { Empty } from 'google-protobuf/google/protobuf/empty_pb';
import { Timestamp } from 'google-protobuf/google/protobuf/timestamp_pb';
import { parsePhoneNumberWithError, PhoneNumber } from 'libphonenumber-js';
import { nanoid } from 'nanoid';
import {
  AccessTokenEntity,
  CreateAccessTokenRequest,
} from 'src/protobuf/socfony_pb';
import { VerificationCodeService } from 'src/verification-code/verification-code.service';
import { AccessTokenService } from './access-token.service';

@Controller()
export class AccessTokenMutation {
  constructor(
    private readonly prisma: PrismaClient,
    private readonly verificationCodeService: VerificationCodeService,
    private readonly accessTokenService: AccessTokenService,
  ) {}

  @GrpcMethod()
  async create(
    data: CreateAccessTokenRequest.AsObject,
  ): Promise<AccessTokenEntity.AsObject> {
    const phone = this.#verifyPhoneNumber(data.phone);
    // Verify SMS verification code.
    const result = await this.verificationCodeService.verify(phone, data.code);

    // Delete verification code.
    this.verificationCodeService.delete(phone, result.code);

    const user = await this.#fetchAutoCreateUser(phone);
    const accessToken = await this.accessTokenService.create(user);

    const entity = new AccessTokenEntity();
    entity.setToken(accessToken.token);
    entity.setExpiredAt(Timestamp.fromDate(accessToken.expiredAt));
    entity.setUserId(user.id);
    entity.setRefreshExpiredAt(
      Timestamp.fromDate(accessToken.refreshExpiredAt),
    );

    return entity.toObject();
  }

  @GrpcMethod()
  async refresh(
    _empty: any,
    metadata: Metadata,
  ): Promise<AccessTokenEntity.AsObject> {
    const accessToken = await this.accessTokenService.verifyWithMatadata(
      metadata,
      {
        refresh: true,
      },
    );
    const result = await this.accessTokenService.refresh(accessToken.token);
    const entity = new AccessTokenEntity();

    entity.setToken(result.token);
    entity.setUserId(accessToken.userId);
    entity.setExpiredAt(Timestamp.fromDate(result.expiredAt));
    entity.setRefreshExpiredAt(Timestamp.fromDate(result.refreshExpiredAt));

    return entity.toObject();
  }

  @GrpcMethod()
  async delete(_empty: any, metadata: Metadata): Promise<Empty.AsObject> {
    const accessToken = await this.accessTokenService.verifyWithMatadata(
      metadata,
    );
    this.accessTokenService.delete(accessToken);

    return new Empty().toObject();
  }

  /**
   * Fetch or create user.
   * @param phone E.164 phone number.
   * @returns {Promise<User>}
   */
  async #fetchAutoCreateUser(phone: string): Promise<User> {
    const user = await this.prisma.user.findUnique({
      where: { phone },
      rejectOnNotFound: false,
    });

    if (user) {
      return user;
    }

    return this.prisma.user.create({
      data: {
        phone,
        id: nanoid(64),
      },
    });
  }

  /**
   * Verify and parse phone number.
   * @param phone phone number.
   * @returns E.164 phone number.
   */
  #verifyPhoneNumber(phone: string): string {
    try {
      const result: PhoneNumber = parsePhoneNumberWithError(phone);
      return result.format('E.164');
    } catch (error) {
      throw new RpcException({
        code: status.INVALID_ARGUMENT,
        message: error.message,
      });
    }
  }
}
