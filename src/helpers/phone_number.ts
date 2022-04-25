import * as libphonenulber from 'libphonenumber-js';
import { ERROR_CODE_PHONE_NUMBER_NOT_VALID } from 'src/errorcodes';

export namespace PhoneNumberHelper {
  /**
   * Is a phone number.
   */
  export function is(phoneNumber: string): boolean {
    return libphonenulber.isValidNumber(phoneNumber);
  }

  /**
   * to e164 format.
   */
  export function e164(phoneNumber: string): string {
    try {
      return libphonenulber.format(phoneNumber, 'E.164');
    } catch (error) {
      throw new Error(ERROR_CODE_PHONE_NUMBER_NOT_VALID);
    }
  }
}
