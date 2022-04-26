import { registerAs } from '@nestjs/config';
import { intParser } from '../utils';

export default registerAs('One-time password', () => ({
  expiresInMinutes: intParser(process.env.OTP_EXPIRES_IN_MINUTES) ?? 5,
  limit: intParser(process.env.OTP_SEND_LIMIT) ?? 5,
}));
