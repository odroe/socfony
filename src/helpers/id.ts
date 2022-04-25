import { nanoid } from 'nanoid';

export namespace IDHelper {
  export const primary = (): string => nanoid(64);
}
