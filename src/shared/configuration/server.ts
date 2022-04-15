import { registerAs } from '@nestjs/config';

export const DEFAULT_SERVER_PORT = 3000;

export default registerAs('server', () => ({
  port: process.env.PORT || DEFAULT_SERVER_PORT,
}));
