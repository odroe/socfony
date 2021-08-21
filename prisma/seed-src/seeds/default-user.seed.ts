import { PrismaClient, User } from "@prisma/client";
import { nanoid } from "nanoid";
import { pbkdf2Sync } from "crypto";

const id = nanoid(64);

const DEFAULT_USER: Pick<User, "id" | "name" | "email" | "password"> = {
  id,
  name: "socfony",
  email: "hello@socfony.com",
  password: pbkdf2Sync("hello", id, 10000, 64, "sha512").toString("hex"),
};

export async function defaultUserSeed(prisma: PrismaClient) {
  const user = await prisma.user.findFirst({
    where: {
      OR: [{ email: DEFAULT_USER.email }, { name: DEFAULT_USER.name }],
    },
  });
  if (!user) {
    return await prisma.user.create({
      data: DEFAULT_USER,
    });
  }

  return user;
}
