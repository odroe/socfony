import { registerAs } from '@nestjs/config';

export const database = registerAs('database', () => ({
  url: process.env.DATABASE_URL,
}));
