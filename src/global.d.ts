import { Prisma, PrismaClient } from "@prisma/client";
import { fieldAuthorizePluginCore } from 'nexus';

// Prisma client mixin interface.
interface ContextMixin {
    prisma: PrismaClient;
}

// declare fastofy module.
declare module "fastify" {
    // Merge PrismaClientMixin into fastify instance.
    interface FastifyInstance extends ContextMixin {}

    // Merge PrismaClientMixin into Fastify request.
    interface FastifyRequest extends ContextMixin {
        accessToken?: Prisma.AccessTokenGetPayload<{
            include: {
                user: true;
            };
        }>;
    }
}

declare global {
    interface NexusGenPluginFieldConfig<TypeName extends string, FieldName extends string> {
        authorize?: fieldAuthorizePluginCore.FieldAuthorizeResolver<TypeName, FieldName>;
    }
}
