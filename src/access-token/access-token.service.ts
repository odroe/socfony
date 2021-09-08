import { Injectable } from '@nestjs/common';
import { PrismaClient, User } from '@prisma/client';
import { pbkdf2Sync } from 'crypto';
import dayjs from 'dayjs';
import { nanoid } from 'nanoid';
import { StorageBox } from 'src/storage-box';
import { StorageBoxInterface } from 'storage-box';
import { SignInArgument, SignType } from './dto/sign-in.arg';

interface AuthSetting {
    value: number;
    unit: dayjs.UnitTypeShort;
}

@Injectable()
export class AccessTokenService {
    constructor(
        private readonly prisma: PrismaClient,
        @StorageBox('auth') private readonly box: StorageBoxInterface,
    ) {}

    async signIn({ password, type, where }: SignInArgument) {
        const user = await this.prisma.user.findUnique({
            where,
            rejectOnNotFound: true,
        });

        if (type === SignType.PASSWORD) {
            return this.#withPasswordLogin(user, password);
        }
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

        return accessToken;
    }

    async #withPasswordLogin(user: User, password: string) {
        const hash = pbkdf2Sync(password, user.id, 10000, 64, 'sha512').toString('hex');
        if (user.password !== hash) {
            throw new Error('Invalid password');
        }

        return this.createAccessToken(user);
    }

    #mergeDefaultSetting(setting: AuthSetting): AuthSetting {
        const defaultSetting = {
            value: 7,
            unit: 'd',
        };

        return { ...defaultSetting, ...setting };
    }
}
