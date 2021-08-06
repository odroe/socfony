import { NextFunction, Request, Response } from 'express';
import { prisma } from '../prisma';

/**
 * Apply a Prisma client to request.
 * @param {Request} request
 * @param {Response} response
 * @param {NextFunction} next
 * @returns {void}
 */
export function applyPrismaClient(request: Request, _response: Response, next: NextFunction) {
    request.prisma = prisma;
    next();
}
