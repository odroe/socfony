import { PrismaClient } from "@prisma/client";

declare global {
    namespace Express {
        interface Request {
            prisma: PrismaClient;
        }
    }
}
