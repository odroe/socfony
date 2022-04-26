import { Parent, ResolveField, Resolver } from '@nestjs/graphql';
import { User } from '@prisma/client';
import { UserSecurityEntity } from 'src/entities';
import { UtilHelpers } from 'src/helpers';

@Resolver(() => UserSecurityEntity)
export class UserSecurityResolver {
  /**
   * Resolve `phone` field.
   */
  @ResolveField('phone', () => String, { nullable: true })
  resolvePhoneField(@Parent() { phone }: User): string | null {
    if (UtilHelpers.isEmpty(phone)) {
      return null;
    }

    // desensitized phone number
    return `${phone!.substring(0, 5)}${'*'.repeat(
      phone!.length - 7,
    )}${phone!.substring(phone!.length - 2)}`;
  }

  /**
   * Resolve `email` field.
   */
  @ResolveField('email', () => String, { nullable: true })
  resolveEmailField(@Parent() { email }: User): string | null {
    if (UtilHelpers.isEmpty(email)) {
      return null;
    }

    const [prefix, domain] = email!.split('@');
    const desensitizedName =
      prefix.length === 1
        ? '*'
        : prefix.length == 2
        ? `${prefix[0]}*`
        : `${prefix[0]}${'*'.repeat(prefix.length - 3)}${
            prefix[prefix.length - 1]
          }`;

    return `${desensitizedName}@${domain}`;
  }

  /**
   * Resolve `password` field.
   */
  @ResolveField('password', () => Boolean, { nullable: true })
  resolvePasswordField(@Parent() { password }: User): boolean {
    return !UtilHelpers.isNotEmpty(password);
  }
}
