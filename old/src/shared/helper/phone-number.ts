import { parsePhoneNumber } from 'libphonenumber-js';

export const formatPhoneToE164 = (phone: string): string =>
  parsePhoneNumber(phone).format('E.164');
