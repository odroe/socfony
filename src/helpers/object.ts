import { UtilHelpers } from './utils';

export namespace ObjectHelper {
  /**
   * Without empty value in object.
   */
  export function withoutEmpty(object: Object): Object {
    return Object.fromEntries(
      Object.entries(object).filter(([_, value]) =>
        UtilHelpers.isNotEmpty(value),
      ),
    );
  }

  /**
   * Get object value by key.
   */
  export function value<T>(
    object: Object,
    key: any,
    defaulrValue?: T,
  ): T | undefined {
    for (const [k, v] of Object.entries(object)) {
      if (k.toLocaleLowerCase() === key.toLocaleLowerCase()) {
        return v;
      }
    }

    return defaulrValue;
  }
}
