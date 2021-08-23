import { nanoid } from "nanoid";
import { StorageBox } from "storage-box";
import {parsePhoneNumberWithError } from 'libphonenumber-js';
import { prisma } from "../prisma";
import { PRISMA_STORAGE_DRIVE_NAME } from "../storage-box";
import { AccessToken, Prisma, User } from "@prisma/client";
import dayjs, { UnitTypeShort } from "dayjs";

const validateUserSmsCodeBox = new StorageBox('validate-user-code-sms', PRISMA_STORAGE_DRIVE_NAME);

function formatPhoneNumber(phone: string): string {
    const result = parsePhoneNumberWithError(phone);
    
    return result.format('E.164');
}

async function validateSmsCode(phone: string, code: string): Promise<void> {
    const sms = await validateUserSmsCodeBox.get<{
        phone: string,
        code: string,
        expiredAt: number,
    }>(phone);
    if (!sms || sms.code !== code || sms.phone !== phone) {
        throw new Error("validate:SMS_NOT_EQUAL");
    } else if (sms.expiredAt < Date.now()) {
        throw new Error("validate:SMS_EXPIRED");
    }
}

function phoneUserFetchAutoCreate(phone: string): Prisma.Prisma__UserClient<User> {
    const id = nanoid(64);
    const mobile = formatPhoneNumber(phone);
    return prisma.user.upsert({
        where: {mobile},
        create: {id, mobile},
        update: {}
    });
}

// Create common storage box
const commonBox = new StorageBox('common', PRISMA_STORAGE_DRIVE_NAME);

// Get HTTP-based auth token setting
function getAuthConfig() {
    return commonBox.get<{
        'lifecycle': {
            value: number,
            unit: UnitTypeShort,
        },
        'refresh': {
            value: number,
            unit: UnitTypeShort,
        },
    }>('auth');
}

async function createAccessToken(userId: string): Promise<AccessToken> {
    const {lifecycle, refresh} = await getAuthConfig();

    const [ accessToken ] = await prisma.$transaction([
        // Create a access token
        prisma.accessToken.create({
            data: {
                userId,
                token: nanoid(128),
                expiredAt: dayjs().add(lifecycle.value, lifecycle.unit).toDate(),
                refreshExpiredAt: dayjs().add(refresh.value, refresh.unit).toDate(),
            }
        }),
        // delate owner expired access token
        prisma.accessToken.deleteMany({
            where: { userId, expiredAt: { lt: new Date() } },
        }),
    ]);

    return accessToken;
}

export async function loginAuthRegister(phone: string, code: string): Promise<AccessToken> {
    // get formated phone number
    const formatedPhoneNumber = formatPhoneNumber(phone);

    // validate sms code
    await validateSmsCode(formatedPhoneNumber, code);

    // Delete SMS
    await validateUserSmsCodeBox.remove(phone);
    
    const user = await phoneUserFetchAutoCreate(formatedPhoneNumber);

    return createAccessToken(user.id);
}

export async function loginWuthPassword(params: Pick<User, 'password'> & Omit<Prisma.UserWhereUniqueInput, 'id'>): Promise<AccessToken> {
    const { password, ...where } = params;
    const user = await prisma.user.findUnique({
        where,
        rejectOnNotFound: true,
    });

    return createAccessToken(user.id);
}
    