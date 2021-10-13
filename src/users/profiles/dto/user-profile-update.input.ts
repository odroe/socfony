import { Field, InputType, OmitType, PartialType } from "@nestjs/graphql";
import { Prisma } from "@prisma/client";
import { UserProfile } from "../entities/profile.entity";

@InputType()
export class UserProfileUpdateInput extends PartialType(OmitType(UserProfile, <const> ['avatar', 'user', 'userId']), InputType) implements Omit<Prisma.UserProfileUpdateInput, 'user'> {
    @Field(() => String, { nullable: true, description: "Avatar resource key" })
    avatar?: string | null;
}
