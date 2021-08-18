import { fieldAuthorizePlugin, makeSchema } from "nexus";
import { $settings } from "nexus-prisma";
import nexusPrismaScalars from 'nexus-prisma/scalars';
import * as resolvers from '../resolvers';

// Make a schema
export const schema = makeSchema({
    types: [
        nexusPrismaScalars,
        resolvers,
    ],
    plugins: [
        fieldAuthorizePlugin(),
    ],
});

// Nexus runtime settings.
$settings({
    prismaClientContextField: 'prisma',
});
