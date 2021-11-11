import { PrismaClient } from '@prisma/client';
import { Metadata } from '@grpc/grpc-js';
import { Controller } from '@nestjs/common';
import { GrpcMethod } from '@nestjs/microservices';
import { VerificationCodeMessage } from './verification-code.message';
import { VerificationCodeService } from './verification-code.service';

import { StringValue } from 'google-protobuf/google/protobuf/wrappers_pb';
import { Empty } from 'google-protobuf/google/protobuf/empty_pb';
import { parsePhoneNumber } from 'libphonenumber-js';
import { AccessTokenService } from 'src/access-token/access-token.service';

@Controller()
export class VerificationCodeMutation {
  constructor(
    private readonly verificationCodeService: VerificationCodeService,
    private readonly prisma: PrismaClient,
    private readonly accessTokenService: AccessTokenService,
  ) {}

  @GrpcMethod()
  async send(
    data: StringValue.AsObject,
    metadata: Metadata,
  ): Promise<Empty.AsObject> {
    const phoneNumber = await this.#resolvePhoneNumber(data, metadata);
    const message = await VerificationCodeMessage.createMessage(
      this.prisma,
      phoneNumber,
    );

    await this.verificationCodeService.send(message);

    return new Empty().toObject();
  }

  async #resolvePhoneNumber(
    data: StringValue.AsObject,
    metadata: Metadata,
  ): Promise<string> {
    if (data.value) {
      return parsePhoneNumber(data.value).format('E.164');
    }

    const [authentication] = metadata.get('authorization');
    const decoded =
      typeof authentication === 'string'
        ? authentication
        : authentication.toString();

    const token = await this.accessTokenService.verify(decoded, {
      include: true,
    });

    return token.User.phone;
  }
}
