import { PrismaClient } from "@prisma/client";
import { StorageBoxDriveInterface, StorageBoxInterface } from "storage-box";

export class StorageBoxPrismaDrive implements StorageBoxDriveInterface {
    constructor(
        private readonly prisma: PrismaClient,
        private readonly box: StorageBoxInterface,
    ) {}

    async get<T>(key: string): Promise<T> {
        const line = await this.prisma.setting.findUnique({
            select: { value: true },
            where: {
                name_key: {
                    name: this.box.name,
                    key,
                }
            },
            rejectOnNotFound: false,
        });

        return line?.value as T;
    }

    set<T>(key: string, value: T): Promise<void> {
        return this.prisma.setting.upsert({
            where: {
                name_key: {
                    name: this.box.name,
                    key,
                }
            },
            create: {
                name: this.box.name,
                key,
                value,
            },
            update: { value },
        }) as any;
    }

    remove(key: string): Promise<void> {
        return this.prisma.setting.delete({
            select: null,
            where: {
              name_key: {
                name: this.box.name,
                key,
              },
            },
          }) as any;
    }
}
