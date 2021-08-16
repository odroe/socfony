import { FastifyRequest } from "fastify";
import { nullable, queryField, core, idArg, stringArg } from "nexus";
import { User } from "nexus-prisma";
import { UserEntity } from "./user.entity";
import schema from './find-one-user.schema.json';
import { ajv } from "../runtime/ajv";

// Create the query args.
const args: core.ArgsRecord = {
    id: nullable(idArg({ description: User.id.description })),
    name: nullable(stringArg({ description: User.name.description })),
    email: nullable(stringArg({ description: User.email.description })),
    mobile: nullable(stringArg({ description: User.mobile.description })),
};

// Create the query args validate.
const validate = ajv.compile<typeof args>(schema);

export const findOneUserQuery = queryField('user', {
    args,
    description: "Find one user.",
    type: nullable(UserEntity),
    resolve(_root, args, { prisma }: FastifyRequest) {
        if (validate(args) === false) {
            throw new Error('ajv-validate/json:' + JSON.stringify(validate.errors));
        }

        return prisma.user.findUnique({
            where: args,
            rejectOnNotFound: true,
        });
    },
});
