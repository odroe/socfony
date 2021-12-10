import { PrismaClient } from '.prisma/client';
import {
  Args,
  ID,
  Mutation,
  Parent,
  Query,
  ResolveField,
  Resolver,
} from '@nestjs/graphql';
import { Auth } from 'shared/auth/auth.decorator';
import { VerificationCodeService } from 'verification_code/verification_code.service';
import { UserUpdatePhoneArgs } from './dto/user_update_phone.args';
import { User } from './entities/user.entity';

@Resolver(() => User)
export class UserResolver {
  constructor(
    private readonly verificationCodeService: VerificationCodeService,
    private readonly prisma: PrismaClient,
  ) {}

  @Query(() => User)
  user(@Args('id', { type: () => ID }) id: string) {
    return this.prisma.user.findUnique({ where: { id } });
  }

  @Query(() => [User])
  users(@Args('in', { type: () => [ID] }) ids: string[]) {
    return this.prisma.user.findMany({
      where: {
        id: { in: ids },
      },
    });
  }

  @Mutation(() => User)
  @Auth()
  async updateUserAccountName(
    @Args('name', { type: () => String }) name: string,
    @Auth.user() user: User,
  ) {
    const exists = await this.prisma.user.findUnique({
      where: { name },
    });

    if (exists && exists.id !== user.id) {
      throw new Error('Name is already taken');
    }

    return this.prisma.user.update({
      where: { id: user.id },
      data: { name },
    });
  }

  @Mutation(() => User)
  @Auth()
  async updateUserPhone(
    @Args({ type: () => UserUpdatePhoneArgs }) args: UserUpdatePhoneArgs,
    @Auth.user() user: User,
  ) {
    const { phone, otp, currentOtp } = args;
    if (phone == user.phone && user.phone) {
      throw new Error('Phone number is already set');
    }

    const exists = await this.prisma.user.findUnique({
      where: { phone },
    });
    if (exists && exists.id !== user.id) {
      throw new Error('Phone is already taken');
    }

    if (!(await this.verificationCodeService.verify(phone, otp))) {
      throw new Error('Invalid OTP');
    }
    if (currentOtp && user.phone) {
      if (
        !(await this.verificationCodeService.verify(user.phone, currentOtp))
      ) {
        throw new Error('Invalid current OTP');
      }
    }

    const result = await this.prisma.user.update({
      where: { id: user.id },
      data: { phone },
    });

    if (user.phone && currentOtp) {
      await this.verificationCodeService.delete(user.phone, currentOtp);
    }
    await this.verificationCodeService.delete(phone, otp);

    return result;
  }

  @ResolveField(() => String)
  phone(@Parent() { phone }: User) {
    if (phone) {
      return '*'.repeat(phone.length - 2) + phone.substring(-2);
    }

    return null;
  }
}
