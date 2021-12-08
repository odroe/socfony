import { Injectable } from '@nestjs/common';
import { AccessToken, Prisma, PrismaClient, User } from '@prisma/client';
import { nanoid } from 'nanoid';

@Injectable()
export class AccessTokenService {
  constructor(private readonly prisma: PrismaClient) {}

  async authRegister(phone: string): Promise<AccessToken> {
    const user = await this.autoCreateUser(phone);

    return this.create(user);
  }

  async create(user: string | User): Promise<AccessToken> {
    const userId = typeof user === 'string' ? user : user.id;
    const { expiredIn, refreshIn } = await this.getOptions();
    const result = await this.prisma.accessToken.create({
      data: {
        userId,
        token: nanoid(128),
        expiredAt: new Date(Date.now() + expiredIn * 1000),
        refreshExpiredAt: new Date(Date.now() + refreshIn * 1000),
      },
    });

    this.deleteAllExpired();

    return result;
  }

  async refresh(accessToken: AccessToken): Promise<AccessToken> {
    // 当前 Token 设置为五分钟后过期
    // 五分钟之内还能使用，但是不能刷新
    await this.prisma.accessToken.update({
      where: { token: accessToken.token },
      data: {
        expiredAt: new Date(Date.now() + 60 * 5 * 1000),
        refreshExpiredAt: new Date(),
      },
    });

    return this.create(accessToken.userId);
  }

  async delete(accessToken: AccessToken): Promise<void> {
    await this.prisma.accessToken.delete({
      where: { token: accessToken.token },
    });

    await this.deleteAllExpired();
  }

  private async deleteAllExpired(): Promise<void> {
    await this.prisma.accessToken.deleteMany({
      where: {
        expiredAt: { lt: new Date() },
        refreshExpiredAt: { lt: new Date() },
      },
    });
  }

  private async autoCreateUser(phone: string): Promise<User> {
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

  private async getOptions(): Promise<{
    expiredIn: number;
    refreshIn: number;
  }> {
    const row = await this.prisma.configuration.findUnique({
      where: {
        key: 'access-token-options',
      },
      rejectOnNotFound: false,
    });
    const options: Prisma.JsonObject | null | undefined =
      row?.value as Prisma.JsonObject;
    const expiredIn = (options?.expiredIn as number) ?? 60 * 60;
    const refreshIn = (options?.refreshIn as number) ?? 60 * 60 * 24 * 7;

    return { expiredIn, refreshIn };
  }
}
