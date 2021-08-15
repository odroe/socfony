import { PrismaClient } from "@prisma/client";
import Ajv from 'ajv';

// Prisma client mixin interface.
interface ContextMixin {
    prisma: PrismaClient;
}

// declare fastofy module.
declare module "fastify" {
    // Merge PrismaClientMixin into fastify instance.
    interface FastifyInstance extends ContextMixin {}

    // Merge PrismaClientMixin into Fastify request.
    interface FastifyRequest extends ContextMixin {}
}
