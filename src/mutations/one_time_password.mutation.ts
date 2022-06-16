import { Args, Mutation, Resolver } from '@nestjs/graphql';
import { AccessToken } from '@prisma/client';
import { Auth } from 'src/auth';
import { PhoneNumberHelper, UtilHelpers } from 'src/helpers';
import { OneTimePasswordService, UserService } from 'src/services';

@Resolver(() => Boolean)
export class OntTimePasswordMutation {
  constructor(
    private readonly oneTimePasswordService: OneTimePasswordService,
    private readonly userService: UserService,
  ) {}

  @Mutation(() => Boolean, {
    name: 'sendOneTimePasswordToPhone',
    description: 'Send one-time password to phone',
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
    await this.oneTimePasswordService.sendToPhone(
      PhoneNumberHelper.e164(target!),
    );

    return true;
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
