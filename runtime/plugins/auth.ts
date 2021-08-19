// Create auth plugin for fastify.

import { AccessToken, PrismaClient } from "@prisma/client";
import { FastifyRequest } from "fastify";
import fp from "fastify-plugin";

// Using http authorization string fetch the AccessToken from Prisma.
function fetchAccessToken(prisma: PrismaClient, authorization: string) {
  return prisma.accessToken.findUnique({
    where: {
      token: authorization,
    },
    include: {
      user: true,
    },
    rejectOnNotFound: false,
  });
}

// Validate the access token is expired.
function tokenExpired(accessToken?: AccessToken | null) {
  if (accessToken) {
    return accessToken.expiredAt < new Date();
  }

  return true;
}

// Create the auth plugin on request, it will check the authorization header
// and return a 401 if the header is not set.
async function auth(request: FastifyRequest) {
  // Get the authorization header.
  // get prisma client.
  const {
    prisma,
    headers: { authorization },
  } = request;

  // Check if the authorization header is set.
  if (!authorization) {
    return;
  }

  // Fetch the access token.
  const accessToken = await fetchAccessToken(prisma, authorization);

  // Check if the access token is expired.
  if (accessToken && tokenExpired(accessToken)) {
    return;
  }

  // Set the access token on the request.
  request.accessToken = accessToken ?? undefined;
}

// Define the auth plugin.
export const applyAuthPlugin = fp(
  async (app) => {
    app.addHook("onRequest", auth);
  },
  {
    name: "auth",
    dependencies: ["prisma"],
  }
);
