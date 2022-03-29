import { registerAs } from '@nestjs/config';

export const DEFAULT_GRAPHQL_ENDPOINT: string = '/graphql';

export default registerAs('graphql', () => ({
  path: process.env.GRAPHQL_PATH || DEFAULT_GRAPHQL_ENDPOINT,
}));
