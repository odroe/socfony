import { parsePhoneNumber } from 'libphonenumber-js';

export function phoneNumberDesensitization(
  value?: string,
): string | null | undefined {
  if (value) {
    const result = parsePhoneNumber(value);

    return `${result.countryCallingCode} ${result.nationalNumber.replace(
      /^(\d{3})\d+(\d{2})/,
      '$1******$2',
    )}`;
  }

  return value;
}
