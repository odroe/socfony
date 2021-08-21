import { JSONSchemaType } from "ajv";
import { mutationField, nonNull, nullable, stringArg } from "nexus";
import { User } from "nexus-prisma";
import { PrismaClient, User as UserInterface } from "@prisma/client";
import { FastifyRequest } from "fastify";
import { ajv } from "../../services/ajv";
import { AccessTokenEntity } from "./access-token.entity";
import { nanoid } from "nanoid";
import { pbkdf2Sync } from "crypto";

// Define the args for the "signIn" mutation.
const args = <const>{
  name: nullable(stringArg({ description: User.name.description })),
  email: nullable(stringArg({ description: User.email.description })),
  phone: nullable(stringArg({ description: User.mobile.description })),
  password: nonNull(stringArg({ description: User.password.description })),
};

type ArgsValue = Record<keyof typeof args, string>;

// define the "signIn" mutation args validate schema.
const schema: JSONSchemaType<ArgsValue> = {
  type: "object",
  properties: {
    email: { type: "string", format: "email" },
    phone: { type: "string", format: "phone-number" },
    name: { type: "string", pattern: "^[a-zA-Z][a-zA-Z0-9]+$" },
    password: { type: "string" },
  },
  required: ["password"],
  oneOf: [
    { required: ["email"] },
    { required: ["mobile"] },
    { required: ["name"] },
  ],
};

// create a Ajv validate function for the args
const validate = ajv.compile(schema);

// user find resolve
function userResolve(
  prisma: PrismaClient,
  where: Omit<ArgsValue, "password">
): Promise<UserInterface> {
  return prisma.user.findUnique({ where, rejectOnNotFound: true }) as any;
}

// Validate user password.
function validatePassword(user: UserInterface, password: string): boolean {
  if (!user.password) {
    return false;
  }

  // Using PBKDF2 to generate a hash from the password.
  const hash = pbkdf2Sync(password, user.id, 10000, 64, "sha512");

  return hash.toString("hex") === user.password;
}

export const SignInMutation = mutationField("signIn", {
  args,
  type: nonNull(AccessTokenEntity),
  description: "User sign-in, create a access token.",
  async resolve(_root, args: ArgsValue, { prisma }: FastifyRequest) {
    if (validate(args) === false) {
      throw new Error("ajv-validate/json:" + JSON.stringify(validate.errors));
    }
    const { password, ...where } = args;
    const user = await userResolve(prisma, where);

    if (validatePassword(user, password) === false) {
      throw new Error("User password not match");
    }

    return prisma.accessToken.create({
      data: {
        userId: user.id,
        token: nanoid(64),
        expiredAt: new Date(),
        refreshExpiredAt: new Date(),
      },
    });
  },
});
