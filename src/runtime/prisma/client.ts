import { PrismaClient } from "@prisma/client";

interface ApplyPrismaClientToProcess extends NodeJS.Process {
    prisma: PrismaClient;
}

declare var process: ApplyPrismaClientToProcess;

export const prisma: PrismaClient = ((): PrismaClient => {
    if (!process.prisma) {
        process.prisma = new PrismaClient();
    }

    return process.prisma;
})();
