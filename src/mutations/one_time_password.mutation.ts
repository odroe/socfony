import { Args, Mutation, Resolver } from "@nestjs/graphql";
import { AccessToken } from "@prisma/client";
import { Auth } from "src/auth";
import { PhoneNumberHelper, UtilHelpers } from "src/helpers";
import { OneTimePasswordService, UserService } from "src/services";

@Resolver(() => Boolean)
export class OntTimePasswordMutation {
  constructor(
    private readonly oneTimePasswordService: OneTimePasswordService,
    private readonly userService: UserService,
  ) {}

  @Mutation(() => Boolean, {
    name: "sendOneTimePasswordToEmail",
    description: "Send one-time password to email",
    nullable: false,
  })
  @Auth.nullable()
  async sendOneTimePasswordToEmail(
    @Args('email', { nullable: true, type: () => String }) email?: string,
    @Auth.accessToken() accessToken?: AccessToken,
  ): Promise<Boolean> {
    let target: string | undefined | null = email;

    // If email is empty, resolve get email from authencated user.
    if (UtilHelpers.isEmpty(email)) {
      target = await this.#getEmailFromUser(accessToken?.ownerId);
    }

    // If email is not empty, but not valid, return false.
    if (UtilHelpers.isEmpty(target)) return false;

    // Send one-time password to email.
    this.oneTimePasswordService.sendToEmail(target!);

    return true;
  }

  @Mutation(() => Boolean, {
    name: "sendOneTimePasswordToPhone",
    description: "Send one-time password to phone",
    nullable: false,
  })
  @Auth.nullable()
  async sendOneTimePasswordToPhone(
    @Args('phone', { nullable: true, type: () => String }) phone?: string,
    @Auth.accessToken() accessToken?: AccessToken,
  ): Promise<Boolean> {
    let target: string | undefined | null = phone;

    // If phone is empty, resolve get phone from authencated user.
    if (UtilHelpers.isEmpty(phone)) {
      target = await this.#getPhoneFromUser(accessToken?.ownerId);
    }

    // If phone is not empty, but not valid, return false.
    if (UtilHelpers.isEmpty(target)) return false;

    // Send one-time password to phone.
    this.oneTimePasswordService.sendToPhone(
      PhoneNumberHelper.e164(target!),
    );

    return true;
  }

  /**
   * Get email from authencated user.
   */
  async #getEmailFromUser(userId?: string): Promise<string | undefined | null> {
    if (UtilHelpers.isEmpty(userId)) return undefined;

    try {
      return (await this.userService.findUniqueOrThrow({ id: userId })).email;
    } catch (e) {
      return undefined;
    }
  }

  /**
   * Get phone from authencated user.
   */
  async #getPhoneFromUser(userId?: string): Promise<string | undefined | null> {
    if (UtilHelpers.isEmpty(userId)) return undefined;

    try {
      return (await this.userService.findUniqueOrThrow({ id: userId })).phone;
    } catch (e) {
      return undefined;
    }
  }
}