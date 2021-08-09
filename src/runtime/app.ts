import fastify from 'fastify';
import { applyPrismaPlugin } from './plugins';

// Create a fastify instance
export const app = fastify()

// Apply Prisma client instance to fastify instance.
.register(applyPrismaPlugin)
