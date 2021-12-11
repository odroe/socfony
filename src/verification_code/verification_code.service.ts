// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { nanoid, customAlphabet } from 'nanoid';
import { Injectable } from '@nestjs/common';
import { PrismaClient, Prisma } from '@prisma/client';
import { Credential } from 'tencentcloud-sdk-nodejs/tencentcloud/common/interface';
import { Client } from 'tencentcloud-sdk-nodejs/tencentcloud/services/sms/v20210111/sms_client';
import { SendSmsRequest } from 'tencentcloud-sdk-nodejs/tencentcloud/services/sms/v20210111/sms_models';

@Injectable()
export class VerificationCodeService {
  constructor(private readonly prisma: PrismaClient) {}

  private async getOptions(): Promise<Prisma.JsonObject> {
    const row = await this.prisma.configuration.findUnique({
      where: { key: 'tencentcloud-sms' },
      rejectOnNotFound: true,
    });

    return row.value as Prisma.JsonObject;
  }

  private async createClient(options?: [Credential, string]): Promise<Client> {
    let _options: [Credential, string] = options!;
    if (!_options) {
      const value = await this.getOptions();
      _options = [
        {
          secretId: value['secretId'] as string,
          secretKey: value['secretKey'] as string,
        },
        value['region'] as string,
      ];
    }

    const [credential, region] = _options;

    return new Client({
      credential,
      region,
      profile: {},
    });
  }

  private createRequest(
    phone: string,
    otp: string,
    options: Prisma.JsonObject,
  ): SendSmsRequest {
    const params: string[] = (options['templateParams'] as string[]).map(
      (param) => {
        switch (param) {
          case '<code>':
            return otp;
          case '<minutes>':
            return (options['minutes'] as string).toString();
          default:
            return param;
        }
      },
    );

    const request: SendSmsRequest = {
      PhoneNumberSet: [phone],
      SignName: options['signName'] as string,
      TemplateId: options['templateId'] as string,
      SmsSdkAppId: options['appId'] as string,
      TemplateParamSet: params,
    };

    return request;
  }

  private createOtp(): string {
    return customAlphabet('0123456789', 6)();
  }

  private async save(
    phone: string,
    otp: string,
    expiredAt: Date,
  ): Promise<void> {
    await this.prisma.$transaction([
      // insert
      this.prisma.verificationCode.create({
        data: {
          id: nanoid(64),
          phone,
          code: otp,
          expiredAt,
        },
      }),
      // Delete all expired codes
      this.prisma.verificationCode.deleteMany({
        where: {
          expiredAt: {
            lt: new Date(),
          },
        },
      }),
    ]);
  }

  async send(phone: string): Promise<void> {
    const options = await this.getOptions();
    const client = await this.createClient([
      {
        secretId: options['secretId'] as string,
        secretKey: options['secretKey'] as string,
      },
      options['region'] as string,
    ]);
    const otp = this.createOtp();
    const request = this.createRequest(phone, otp, options);

    client.SendSms(request, (err) => {
      if (!err) {
        const minutes = options['minutes'] as number;
        const expiredAt = new Date(new Date().getTime() + minutes * 60 * 1000);
        this.save(phone, otp, expiredAt);
      }
    });
  }

  async verify(phone: string, code: string): Promise<boolean> {
    const row = await this.prisma.verificationCode.findFirst({
      where: { phone, code },
      orderBy: {
        createdAt: 'desc',
      },
      rejectOnNotFound: false,
    });

    if (row && row.expiredAt > new Date()) {
      return true;
    }

    return false;
  }

  async delete(phone: string, otp: string): Promise<void> {
    await this.prisma.verificationCode.deleteMany({
      where: {
        OR: [{ phone, code: otp }, { expiredAt: { lt: new Date() } }],
      },
    });
  }
}
