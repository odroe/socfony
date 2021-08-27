import { Injectable } from '@nestjs/common';
import { AccessToken, PrismaClient, User } from '@prisma/client';
import { pbkdf2Sync } from 'crypto';
import dayjs from 'dayjs';
import { nanoid } from 'nanoid';
import { SignInArgument, SignType } from './dto/sign-in.arg';

@Injectable()
export class AccessTokenService {
    constructor(
        private readonly prisma: PrismaClient,
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

    createAccessToken(user: User) {
        const accessToken = this.prisma.accessToken.create({
            data: {
                token: nanoid(128),
                userId: user.id,
                expiredAt: dayjs().add(1, 'day').toDate(),
                refreshExpiredAt: dayjs().add(1, 'day').toDate(),
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
}
