import { nanoid } from 'nanoid';

export namespace ID {
  export const primary = (): string => nanoid(64);
}
