import fp from 'fastify-plugin';
import { prisma } from '../prisma';

/**
 * Apply Prisma client instance to fastify instance and request
 */
export const applyPrismaPlugin = fp(async (app) => {
    app.decorate("prisma", prisma);
    app.addHook("onRequest", async (request) => {
        request.prisma = prisma;
    });
}, {
    name: "prisma",
});
