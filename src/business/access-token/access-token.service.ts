import { AccessToken, PrismaClient, User, Prisma } from '@prisma/client';
import { Injectable } from '@nestjs/common';
import { nanoid } from 'nanoid';
import * as dayjs from 'dayjs';

interface AccessTokenExpiresSet {
  value?: number;
  unit?: 'second' | 'minute' | 'hour' | 'day' | 'week' | 'month' | 'year';
}

interface AccessTokenExpires {
  expire?: AccessTokenExpiresSet;
  refresh?: AccessTokenExpiresSet;
}

/**
 * Access token service.
 */
@Injectable()
export class AccessTokenService {
  constructor(private readonly prisma: PrismaClient) {}

  /**
   * create access token.
   * @param user Need to be logged in user.
   * @returns AccessToken
   */
  async create(user: User | string): Promise<AccessToken> {
    this.#delteExpiredTokens();

    const [expiredAt, refreshExpiredAt] = await this.#createExpires();

    return this.prisma.accessToken.create({
      data: {
        token: nanoid(128),
        userId: typeof user === 'string' ? user : user.id,
        expiredAt,
        refreshExpiredAt,
      },
    });
  }

  /**
   * find access token by id.
   *
   * @param token Access token id.
   * @param include If true, include user.
   * @returns AccessToken
   */
  find(
    token: string,
    include: boolean = false,
  ): Promise<
    Prisma.AccessTokenGetPayload<{
      include: {
        User: typeof include;
      };
    }>
  > {
    this.#delteExpiredTokens();

    return this.prisma.accessToken.findUnique({
      where: { token },
      include: {
        User: !!include,
      },
      rejectOnNotFound: false,
    });
  }

  /**
   * refresh access token.
   *
   * @param token Access token.
   * @returns AccessToken
   */
  async refresh(token: string): Promise<AccessToken> {
    this.#delteExpiredTokens();

    const [expiredAt, refreshExpiredAt] = await this.#createExpires();

    return this.prisma.accessToken.update({
      where: { token },
      data: {
        token: nanoid(128),
        expiredAt,
        refreshExpiredAt,
      },
    });
  }

  async verify(
    token: string,
    { include = false, refresh = false } = {},
  ): Promise<
    Prisma.AccessTokenGetPayload<{
      include: {
        User: typeof include;
      };
    }>
  > {
    const accessToken = await this.find(token, include);

    if (!accessToken) {
      throw new Error('Access token not found.');
    } else if (
      accessToken[refresh ? 'refreshExpiredAt' : 'expiredAt'] < new Date()
    ) {
      throw new Error('Access token expired.');
    }

    return accessToken;
  }

  /**
   * delete all expired access tokens.
   *
   * @returns void
   */
  async #delteExpiredTokens(): Promise<void> {
    await this.prisma.accessToken.deleteMany({
      where: {
        refreshExpiredAt: {
          lt: new Date(),
        },
      },
    });
  }

  /**
   * create expires Date.
   *
   * @returns [expiredAt, refreshExpiredAt]
   */
  async #createExpires(): Promise<[Date, Date]> {
    const setting = await this.prisma.setting.findUnique({
      where: { key: 'accessTokenExpires' },
      rejectOnNotFound: false,
    });
    const { expire, refresh } = this.#resolveExpires(
      setting?.value as AccessTokenExpires,
    );

    const now = dayjs();
    const expiredAt = now.add(expire.value, expire.unit).toDate();
    const refreshExpiredAt = now.add(refresh.value, refresh.unit).toDate();

    return [expiredAt, refreshExpiredAt];
  }

  /**
   * resolve expires.
   *
   * @param expires access token expires.
   * @returns AccessTokenExpires
   */
  #resolveExpires(expires?: AccessTokenExpires): AccessTokenExpires {
    const { expire = {}, refresh = {} } = expires || {};

    return {
      expire: {
        value: expire.value ?? 1,
        unit: expire.unit ?? 'day',
      },
      refresh: {
        value: refresh.value ?? 7,
        unit: refresh.unit ?? 'day',
      },
    };
  }
}
