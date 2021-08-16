import { FastifyRequest } from "fastify";
import { objectType } from "nexus";
import { AccessToken } from "nexus-prisma";
import { AccessToken as AccessTokenInterface, User as UserInterface } from "@prisma/client";

// Create user field resolve in access token entity.
async function userResolver({ userId: id }: AccessTokenInterface, _args: any, {prisma }: FastifyRequest): Promise<UserInterface> {
    return prisma.user.findUnique({
        where: { id },
        rejectOnNotFound: true,
    });
}

// Define the access token entity.
export const AccessTokenEntity = objectType({
    name: AccessToken.$name,
    description: AccessToken.$description,
    definition(t) {
        t.field(AccessToken.token);
        t.field(AccessToken.userId);
        t.field(AccessToken.createdAt);
        t.field(AccessToken.expiredAt);
        t.field(AccessToken.refreshExpiredAt);
        t.field({
            ...AccessToken.user,
            resolve: userResolver,
        });
    }
});
