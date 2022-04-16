import { Query, Resolver } from "@nestjs/graphql";
import { PrismaClient } from "@prisma/client";

@Resolver()
export class KeyValueResolver {
  constructor(private readonly prisma: PrismaClient) {}

  @Query(() => String, { nullable: true })
  async queryUserAgreement() {
    const kv = await this.prisma.keyValue.findUnique({
      where: { key: 'user-agreement' },
      rejectOnNotFound: false,
    });

    return kv?.value;
  }

  @Query(() => String, { nullable: true })
  async queryPrivacyPolicy() {
    const kv = await this.prisma.keyValue.findUnique({
      where: { key: 'privacy-policy' },
      rejectOnNotFound: false,
    });

    return kv?.value;
  }
  
}