import { ApolloServer } from "apollo-server-express";
import { schema } from './schema';

export const apolloServer = new ApolloServer({ schema });
