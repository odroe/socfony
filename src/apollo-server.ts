import { ApolloServer } from "apollo-server-fastify";
import { schema } from './schema';

export const apolloServer = new ApolloServer({
    schema,
    context: ({ request }) => request,
});
