export function intParser(value?: string | number | null): number | undefined {
  if (typeof value === 'number') {
    return value;
  } else if (!value) {
    return undefined;
  }

  try {
    return parseInt(value);
  } catch (e) {
    return undefined;
  }
}

export function booleanParser(value?: string | number | null): boolean {
  if (typeof value === 'boolean') {
    return value;
  } else if (value === 'true' || value === '1') {
    return true;
  }
  if (typeof value === 'number') {
    return value > 0;
  }

  return false;
}
