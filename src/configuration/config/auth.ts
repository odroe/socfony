import { registerAs } from '@nestjs/config';
import { intParser } from '../utils';

export default registerAs('auth', () => ({
  access: {
    value: intParser(process.env.AUTH_TOKEN_ACCESS_VALUE) || 1,
    unit: process.env.AUTH_TOKEN_ACCESS_UNIT || 'd',
  },
  refresh: {
    value: intParser(process.env.AUTH_TOKEN_REFRESH_VALUE) || 7,
    unit: process.env.AUTH_TOKEN_REFRESH_UNIT || 'd',
  }
}));
