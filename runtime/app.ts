import fastify from "fastify";
import { applyPrismaPlugin, applyAuthPlugin } from "./plugins";

// Create a fastify instance
export const app = fastify()
  //------------------ Start registering plugins ------------------//

  // Register Prisma client instance to fastify instance.
  .register(applyPrismaPlugin)

  // Register auth plugin
  .register(applyAuthPlugin);

//------------------ End registering plugins --------------------//
