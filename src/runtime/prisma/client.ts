import { PrismaClient } from "@prisma/client";

// Apply the client to NodeJS process.
interface ApplyPrismaClientToProcess extends NodeJS.Process {
    prisma: PrismaClient;
}

// Declare the client as a global variable.
declare var process: ApplyPrismaClientToProcess;

// Create a Prisma client instance and apply it to the process.
export const prisma: PrismaClient = ((): PrismaClient => {
    // if process.prisma don't exist, create it.
    if (!process.prisma) {
        process.prisma = new PrismaClient();
    }

    return process.prisma;
})();
