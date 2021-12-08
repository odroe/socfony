import { Resolver, Mutation, Args } from '@nestjs/graphql';

@Resolver()
export class VerificationCodeResolver {
  @Mutation(() => Date)
  removeVerificationCode(@Args('phone', { type: () => String, nullable: true, }) phone?: string) {
    // return this.verificationCodeService.remove(id);
  }
}
