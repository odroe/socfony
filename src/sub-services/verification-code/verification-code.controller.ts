import { Metadata, status } from '@grpc/grpc-js';
import { Controller } from '@nestjs/common';
import { GrpcMethod, RpcException } from '@nestjs/microservices';
import { PrismaClient } from '@prisma/client';
import { parsePhoneNumberWithError, PhoneNumber } from 'libphonenumber-js';
import { Empty } from 'src/protobuf/google/protobuf/Empty';
import { StringValue } from 'src/protobuf/google/protobuf/StringValue';
import {
  AccessTokenService,
  VerificationCodeMessage,
  VerificationCodeService as VerificationCodeBusinessService,
} from '../../business';

@Controller()
export class VerificationCodeSubServiceController {
  constructor(
    private readonly prisma: PrismaClient,
    private readonly service: VerificationCodeBusinessService,
    private readonly accessTokenService: AccessTokenService,
  ) {}

  @GrpcMethod('VerificationCodeService', 'Send')
  async send(data: StringValue): Promise<Empty> {
    const phone = this.#verifyPhoneNumber(data.value);

    try {
      const message = await VerificationCodeMessage.createMessage(
        this.prisma,
        phone,
      );
      this.service.send(message);
    } catch (error) {
      throw new RpcException({
        code: status.INTERNAL,
        message: error.message,
      });
    }

    return {};
  }

  @GrpcMethod('VerificationCodeService', 'SendByAuthenticatedUser')
  async sendByAuthenticatedUser(
    data: Empty,
    metadata: Metadata,
  ): Promise<Empty> {
    const [authorization] = metadata.get('authorization');

    try {
      const accessToken = await this.accessTokenService.verify(
        typeof authorization === 'string'
          ? authorization
          : Buffer.from(authorization).toString(),
        { include: true },
      );

      const message = await VerificationCodeMessage.createMessage(
        this.prisma,
        accessToken.User.phone,
      );

      this.service.send(message);
    } catch (error) {
      throw new RpcException({
        code: status.UNAUTHENTICATED,
        message: error.message,
      });
    }

    return {};
  }

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
