import { Field, ID, ObjectType } from "@nestjs/graphql";
import { Prisma, User as UserInterface } from "@prisma/client";
import { User } from "src/users/entities/user.entity";

type AccessTokenInterface = Prisma.AccessTokenGetPayload<{ include: Record<keyof Prisma.AccessTokenInclude, true> }>;

@ObjectType()
export class AccessToken implements AccessTokenInterface {
    @Field(() => String, { description: 'The access token' })
    token: string;

    @Field(() => ID)
    userId: string;
    createdAt: Date;
    expiredAt: Date;
    refreshExpiredAt: Date;
    user: UserInterface;
}