import { Injectable } from '@nestjs/common';
import { PrismaClient, User } from '@prisma/client';
import * as dayjs from 'dayjs';
import { nanoid } from 'nanoid';
import { StorageBox } from 'src/storage-box';
import { VerificationCodeService } from 'src/verification-code/verification-code.service';
import { StorageBoxInterface } from 'storage-box';
import { LoginArguments } from './dto/login.args';

interface AuthSetting {
  value: number;
  unit: dayjs.UnitType;
}

@Injectable()
export class AccessTokenService {
  constructor(
    private readonly prisma: PrismaClient,
    @StorageBox('auth') private readonly box: StorageBoxInterface,
    private readonly verificationCodeService: VerificationCodeService,
  ) {}

  async login({ phone, code, context }: LoginArguments) {
    const pass = await this.verificationCodeService.verify({
      account: phone,
      code,
      context,
      remove: true,
    });

    if (!pass) {
      throw new Error('VERIFICATION_CODE_FAIL');
    }

    // fetch user, not found, create it.
    const user = await this.#autoRegisterUser(phone);

    return this.createAccessToken(user);
  }

  async createAccessToken(user: User) {
    const setting = this.#mergeDefaultSetting(await this.box.get('expired'));
    const refresh = this.#mergeDefaultSetting(await this.box.get('refresh'));
    const accessToken = this.prisma.accessToken.create({
      data: {
        token: nanoid(128),
        userId: user.id,
        expiredAt: dayjs().add(setting.value, setting.unit).toDate(),
        refreshExpiredAt: dayjs().add(refresh.value, refresh.unit).toDate(),
      },
    });

    // delete all expired access tokens
    this.#deleteAllExpiredAccessTokens();

    return accessToken;
  }

  async #deleteAllExpiredAccessTokens() {
    await this.prisma.accessToken.deleteMany({
      where: {
        refreshExpiredAt: {
          lt: new Date(),
        },
      },
    });
  }

  async #autoRegisterUser(phone: string) {
    const user = await this.prisma.user.findUnique({
      where: { phone },
      rejectOnNotFound: false,
    });

    if (!user) {
      return this.prisma.user.create({
        data: {
          id: nanoid(64),
          phone,
        },
      });
    }

    return user;
  }

  #mergeDefaultSetting(setting: AuthSetting): AuthSetting {
    const defaultSetting = {
      value: 7,
      unit: 'd',
    };

    return { ...defaultSetting, ...setting };
  }
}
