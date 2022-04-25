import { customAlphabet, nanoid } from 'nanoid';

export namespace IDHelper {
  /**
   * Table primary key.
   * @returns string
   */
  export const primary = (): string => nanoid(64);

  /**
   * Access token primary key.
   */
  export function token(): string {
    return nanoid(128);
  }

  /**
   * numeric nanoid.
   */
  export const numeric = customAlphabet('0123456789', 6);

  /**
   * One-time password.
   */
  export function oneTimePassword(): string {
    return numeric(6);
  }
}
