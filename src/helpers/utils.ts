export namespace UtilHelpers {
  export function isEmpty(obj: any): boolean {
    if (obj === null || obj === undefined) {
      return true;
    } else if (Array.isArray(obj)) {
      return obj.length === 0;
    } else if (typeof obj === 'string') {
      return obj.trim().length === 0;
    } else if (typeof obj === 'object') {
      return Object.keys(obj).length === 0;
    }
    return false;
  }

  export function isNotEmpty(obj: any): boolean {
    return !isEmpty(obj);
  }
}
