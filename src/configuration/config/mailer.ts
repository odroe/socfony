import { registerAs } from '@nestjs/config';
import { booleanParser, intParser } from '../utils';

export default registerAs('mailer', () => ({
  host: process.env.MAILER_HOST,
  port: intParser(process.env.MAILER_PORT) || 465,
  user: process.env.MAILER_USER,
  pass: process.env.MAILER_PASS,
  name: process.env.MAILER_NAME,
  secure: booleanParser(process.env.MAILER_SECURE),
}));
