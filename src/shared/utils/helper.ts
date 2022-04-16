export namespace Helper {
  /// Is empty
  export const isEmpty = (value: any): boolean => {
    if (value === null || value === undefined) {
      return true;
    }
    if (typeof value === 'string') {
      return value.trim().length === 0;
    }
    if (typeof value === 'object') {
      return Object.keys(value).length === 0;
    }
    return false;
  };

  // Is not empty
  export const isNotEmpty = (value: any): boolean => !isEmpty(value);
}
