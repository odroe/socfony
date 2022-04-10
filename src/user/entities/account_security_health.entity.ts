import { Field, ObjectType } from '@nestjs/graphql';
import { parsePhoneNumber } from 'libphonenumber-js';
import { UserSecurityFields } from '../dto/update-user-security.args';

function desensitizedEmail(email?: string | null): string | null {
  if (!email) return null;

  const [prefix, domain] = email.split('@');

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

function desensitizedPhone(phone?: string | null): string | null {
  if (!phone) return null;

  const e164 = parsePhoneNumber(phone).format('E.164');

  return `${e164.substring(0, 5)}${'*'.repeat(e164.length - 7)}${e164.substring(
    e164.length - 2,
  )}`;
}

@ObjectType()
export class AccountSecurityHealthResult {
  constructor(
    field: UserSecurityFields,
    status: boolean,
    message?: string | null,
  ) {
    this.field = field;
    this.status = status;
    this.message = message;
  }

  static fromPassword(password?: string | null) {
    return new AccountSecurityHealthResult(
      UserSecurityFields.PASSWORD,
      !!password,
    );
  }
  static fromEmail(email?: string | null) {
    return new AccountSecurityHealthResult(
      UserSecurityFields.EMAIL,
      !!email,
      desensitizedEmail(email),
    );
  }
  static fromPhone(phone?: string | null) {
    return new AccountSecurityHealthResult(
      UserSecurityFields.PHONE,
      !!phone,
      desensitizedPhone(phone),
    );
  }

  @Field(() => UserSecurityFields)
  field: UserSecurityFields;

  @Field(() => Boolean)
  status: boolean;

  @Field(() => String, { nullable: true })
  message?: string | null;
}
