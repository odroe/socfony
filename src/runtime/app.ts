import express from 'express';
import { applyPrismaClient } from './middleware';

export const app = express().use(
    // Apply Prisma client to Express request.
    applyPrismaClient,
);
