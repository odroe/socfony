import { StorageBox } from "storage-box";
import {
  PrismaStorageBoxDirve,
  PRISMA_STORAGE_DRIVE_NAME,
} from "../storage-box";

export const tencentCloudStorageBox = new StorageBox<PrismaStorageBoxDirve>(
  "tencent-cloud",
  PRISMA_STORAGE_DRIVE_NAME
);
