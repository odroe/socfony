import { StorageBox, StorageBoxDriveInterface, StorageBoxInterface } from "storage-box";
import { prisma } from '../prisma';

export class PrismaStorageBoxDirve implements StorageBoxDriveInterface {
    constructor(private readonly box: StorageBoxInterface) {}

    async get<T>(key: string): Promise<T> {
        const storageBox = await prisma.storageBox.findUnique({
            select: {
                value: true,
            },
            where: {
                name_key: {
                    name: this.box.name,
                    key,
                },
            },
            rejectOnNotFound: false,
        });

        return storageBox?.value as T;
    }

    set<T>(key: string, value: T): Promise<void> {
        return prisma.storageBox.upsert({
            select: null,
            where: {
                name_key: {
                    name: this.box.name,
                    key,
                },
            },
            update: { value },
            create: {
                name: this.box.name,
                key,
                value,
            },
        }) as any;
    }

    remove(key: string): Promise<void> {
        return prisma.storageBox.delete({
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

export const prismaStorageBoxDrive = (box: StorageBoxInterface): PrismaStorageBoxDirve => new PrismaStorageBoxDirve(box);

export const PRISMA_STORAGE_DRIVE_NAME = 'prisma';

StorageBox.register(PRISMA_STORAGE_DRIVE_NAME, prismaStorageBoxDrive);

