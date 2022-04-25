import { nanoid } from 'nanoid';

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
}
