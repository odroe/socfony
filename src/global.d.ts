import { PrismaClient } from "@prisma/client";

// Prisma client mixin interface.
interface PrismaClientMixin {
    prisma: PrismaClient;
}

// declare fastofy module.
declare module "fastify" {
    // Merge PrismaClientMixin into fastify instance.
    interface FastifyInstance extends PrismaClientMixin {}

    // Merge PrismaClientMixin into Fastify request.
    interface FastifyRequest extends PrismaClientMixin {}
}
