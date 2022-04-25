import { Args, Mutation, Resolver } from '@nestjs/graphql';
import { AccessToken, PrismaClient } from '@prisma/client';
import {
  UpdateUserEmailArgs,
  UpdateUserPasswordArgs,
  UpdateUserPhoneArgs,
} from 'src/args';
import { Auth } from 'src/auth';
import { UserSecurityEntity } from 'src/entities';
import { UserSecurityService } from 'src/services';

@Resolver(() => UserSecurityEntity)
export class UserSecurityMutation {
  constructor(private readonly userSecurityService: UserSecurityService) {}

  /**
   * Update authencated user phone.
   */
  @Mutation(() => UserSecurityEntity, {
    description: 'Update authencated user phone.',
  })
  @Auth.must()
  updateAuthencatedUserPhone(
    @Auth.accessToken() { ownerId }: AccessToken,
    @Args({ type: () => UpdateUserPhoneArgs }) args: UpdateUserPhoneArgs,
  ) {
    return this.userSecurityService.updateUserPhone(
      ownerId,
      { phone: args.phone, otp: args.otp },
      args.validator,
    );
  }

  /**
   * Update authencated user email.
   */
  @Mutation(() => UserSecurityEntity, {
    description: 'Update authencated user email.',
  })
  @Auth.must()
  updateAuthencatedUserEmail(
    @Auth.accessToken() { ownerId }: AccessToken,
    @Args({ type: () => UpdateUserEmailArgs }) args: UpdateUserEmailArgs,
  ) {
    return this.userSecurityService.updateUserEmail(
      ownerId,
      { email: args.email, otp: args.otp },
      args.validator,
    );
  }

  /**
   * Update authencated user password.
   */
  @Mutation(() => UserSecurityEntity, {
    description: 'Update authencated user password',
  })
  @Auth.must()
  updateAuthencatedUserPassword(
    @Auth.accessToken() { ownerId }: AccessToken,
    @Args({ type: () => UpdateUserPasswordArgs }) args: UpdateUserPasswordArgs,
  ) {
    return this.userSecurityService.updateUserPassword(
      ownerId,
      args.password,
      args.validator,
    );
  }
}
