import { ApolloServer } from "apollo-server-fastify";
import { FastifyRequest } from "fastify";
import { schema } from './schema';

// Create an instance of the Apollo Server
export const apolloServer = new ApolloServer({
    schema,
    context: ({ request }): FastifyRequest => request,
});
