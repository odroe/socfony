import { PrismaClient } from "@prisma/client";

declare const global: { prisma?: PrismaClient };

// Create a Prisma client instance and apply it to the process.
export const prisma: PrismaClient = ((): PrismaClient => {
    // if process.prisma don't exist, create it.
    if (!global.prisma) {
        global.prisma = new PrismaClient();
    }

    return global.prisma;
})();
