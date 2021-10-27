import { PrismaClient, User } from '@prisma/client';
import { Metadata, status } from '@grpc/grpc-js';
import { Controller } from '@nestjs/common';
import { GrpcMethod, RpcException } from '@nestjs/microservices';
import { parsePhoneNumberWithError, PhoneNumber } from 'libphonenumber-js';
import { AccessTokenService, VerificationCodeService } from 'src/business';
import { AccessTokenResponse } from 'src/protobuf/odroe/socfony/AccessTokenResponse';
import { CreateAccessTokenRequest } from 'src/protobuf/odroe/socfony/CreateAccessTokenRequest';
import { nanoid } from 'nanoid';
import { Empty } from 'src/protobuf/google/protobuf/Empty';
import { auth } from 'src/grpc-helper';

@Controller()
export class AccessTokenSubServiceController {
  constructor(
    private readonly accessTokenService: AccessTokenService,
    private readonly verificationCodeService: VerificationCodeService,
    private readonly prisma: PrismaClient,
  ) {}

  /**
   * Create access token
   *
   * @param {CreateAccessTokenRequest} request
   * @returns {Promise<AccessTokenResponse>}
   */
  @GrpcMethod('AccessTokenService', 'Create')
  async create(
    request: CreateAccessTokenRequest,
  ): Promise<AccessTokenResponse> {
    // Verify and parse phone number.
    const phone = this.#verifyPhoneNumber(request.phone);

    try {
      // Verify SMS verification code.
      const result = await this.verificationCodeService.verify(
        phone,
        request.code,
      );
      // Delete verification code.
      this.verificationCodeService.delete(phone, result.code);

      const user = await this.#fetchAutoCreateUser(phone);
      const accessToken = await this.accessTokenService.create(user);

      return {
        userId: user.id,
        token: accessToken.token,
        expiredAt: { value: accessToken.expiredAt.toISOString() },
        refreshExpiredAt: { value: accessToken.refreshExpiredAt.toISOString() },
      };
    } catch (error) {
      throw new RpcException({
        code: status.INVALID_ARGUMENT,
        message: error.message,
      });
    }
  }

  @GrpcMethod('AccessTokenService', 'Delete')
  async delete(_request: Empty, metadata: Metadata): Promise<Empty> {
    const accessToken = await auth({
      accessTokenService: this.accessTokenService,
      metadata,
    });

    await this.prisma.accessToken.delete({
      where: { token: accessToken.token },
    });

    return {};
  }

  @GrpcMethod('AccessTokenService', 'Refresh')
  async refresh(
    _request: Empty,
    metadata: Metadata,
  ): Promise<AccessTokenResponse> {
    const accessToken = await auth({
      accessTokenService: this.accessTokenService,
      metadata,
    });

    const newAccessToken = await this.accessTokenService.refresh(
      accessToken.token,
    );

    return {
      userId: accessToken.userId,
      token: newAccessToken.token,
      expiredAt: { value: newAccessToken.expiredAt.toISOString() },
      refreshExpiredAt: {
        value: newAccessToken.refreshExpiredAt.toISOString(),
      },
    };
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
