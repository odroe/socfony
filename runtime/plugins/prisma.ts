import fp from 'fastify-plugin';
import { prisma } from '../../services';

/**
 * Apply Prisma client instance to fastify instance and request
 */
export const applyPrismaPlugin = fp(async (app) => {
    // Apply Prisma client instance to fastify instance
    app.decorate("prisma", prisma);
    // Apply Prisma client instance to request
    app.addHook("onRequest", async (request) => {
        // Set the Prisma client instance to the request
        request.prisma = prisma;
    });
}, {
    // The name of the plugin.
    name: "prisma",
});
