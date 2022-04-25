import * as bcrypt from 'bcrypt';

export namespace PasswordHelper {
  /**
   * Generate a salt.
   */
  export function generateSalt(): string {
    return bcrypt.genSaltSync(10);
  }

  /**
   * Hash a password.
   */
  export function hash(password: string, salt?: string): string {
    return bcrypt.hashSync(password, salt ?? generateSalt());
  }

  /**
   * Compare a password with a hash.
   * @param password The password to compare.
   * @param hash The hash to compare with.
   * @returns True if the password matches the hash.
   */
  export function compare(password: string, hash: string): boolean {
    return bcrypt.compareSync(password, hash);
  }
}