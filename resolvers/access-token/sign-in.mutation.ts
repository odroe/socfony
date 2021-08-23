import { JSONSchemaType } from "ajv";
import { enumType, mutationField, nonNull, nullable, stringArg, } from "nexus";
import { User } from "nexus-prisma";
import { PrismaClient, User as UserInterface } from "@prisma/client";
import { FastifyRequest } from "fastify";
import { ajv } from "../../services/ajv";
import { AccessTokenEntity } from "./access-token.entity";
import { pbkdf2Sync } from "crypto";

enum _SignInType {
  password = 'password',
  otp = 'otp',
}

export const SignInType = enumType({
  name: 'SignInType',
  members: _SignInType,
  description: 'Sign in type',
});

// Define the args for the "signIn" mutation.
const args = <const>{
  name: nullable(stringArg({ description: User.name.description })),
  email: nullable(stringArg({ description: User.email.description })),
  phone: nullable(stringArg({ description: User.mobile.description })),
  password: nonNull(stringArg({ description: User.password.description })),
  passwordType: nonNull(SignInType.asArg()),
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
    passwordType: {
      type: "string",
      enum: ["password", "otp"]
    },
  },
  required: ["password", "passwordType"],
  if: {
    properties: {
      passwordType: { const: "otp" }
    }
  },
  then: {
    required: ["phone"]
  },
  else: {
    oneOf: [
      { required: ["email"] },
      { required: ["phone"] },
      { required: ["name"] },
    ],
  }
};

// create a Ajv validate function for the args
const validate = ajv.compile(schema);

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
    const { password, passwordType, ...where } = args;
    
    if (passwordType === _SignInType.otp) {
      return loginAutoReguster(prisma, where);
    }
    
  },
});
