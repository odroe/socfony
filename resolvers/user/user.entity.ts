import { objectType } from "nexus";
import { User } from 'nexus-prisma';
import { User as UserInterface } from '@prisma/client';
import { FastifyRequest } from "fastify";

// Chack User password has set.
const hasSetPassword = (user: UserInterface) => !!user.password;

/// Define a User entity.
export const UserEntity = objectType({
    name: User.$name,
    description: User.$description,
    definition(t) {
        t.field(User.id);
        t.field(User.name);
        t.field(User.email);
        t.field(User.mobile);
        t.field(User.registeredAt);
        t.boolean('hasSetPassword', {
            description: "The user's password has set.",
            authorize: (root: UserInterface, _args, { accessToken }: FastifyRequest) => root.id === accessToken?.userId,
            resolve: (root: UserInterface) => hasSetPassword(root),
        });
    },
});
