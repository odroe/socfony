import { Injectable } from "@nestjs/common";
import dayjs = require("dayjs");
import { StorageBox } from "src/storage-box";
import { StorageBoxInterface } from "storage-box";
import crypto = require("crypto");

const md5 = crypto.createHash("md5");

export type VerificationCodeStoreValue = {
    context: string;
    code: string;
    expiredAt: Date;
    account: string;
};

@Injectable()
export class VerificationCodeService {
    constructor(
        @StorageBox('cache') private readonly cache: StorageBoxInterface,
    ) {}

    async store(data: VerificationCodeStoreValue): Promise<VerificationCodeStoreValue> {
        data.account = md5.update(data.account).digest('hex');

        await this.cache.set(data.context, data);

        return data;
    }

    async verify<T>(args: Pick<VerificationCodeStoreValue, 'account' | 'code' | 'context'> & { remove?: boolean }): Promise<boolean> {
        const value = await this.cache.get<VerificationCodeStoreValue>(args.context);
        const accountHex = md5.update(args.account).digest('hex');

        if (!value) {
            return false;
        } else if (value.account !== accountHex) {
            return false;
        } else if (value.code !== args.code) {
            return false;
        } else if (dayjs(value.expiredAt).isBefore(dayjs())) {
            return false;
        } else if (args.remove) {
            this.destroy(args.context);
        }

        return true;
    }

    destroy(context: string): Promise<void> {
        return this.cache.remove(context);
    }
}
