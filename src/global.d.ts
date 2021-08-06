import { PrismaClient } from "@prisma/client";

interface PrismaClientMixin {
    prisma: PrismaClient;
}

declare module "fastify" {
    interface FastifyInstance extends PrismaClientMixin {}
    interface FastifyRequest extends PrismaClientMixin {}
}
