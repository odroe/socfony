import { registerAs } from '@nestjs/config';

export const DEFAULT_AUTH_TOKEN_EXPIRES_IN = '1d';
export const DEFAULT_AUTH_TOKEN_REFRESH_EXPIRES_IN = '7d';

export default registerAs('auth', () => ({
  expiresIn: process.env.AUTH_TOKEN_EXPIRED_IN || DEFAULT_AUTH_TOKEN_EXPIRES_IN,
  refreshExpiresIn:
    process.env.AUTH_REFRESH_TOKEN_EXPIRED_IN ||
    DEFAULT_AUTH_TOKEN_REFRESH_EXPIRES_IN,
}));
