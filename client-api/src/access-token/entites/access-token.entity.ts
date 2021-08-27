import { Field, GraphQLISODateTime, ID, ObjectType } from "@nestjs/graphql";
import { Prisma, User as UserInterface } from "@prisma/client";
import { User } from "../../users/entities/user.entity";

type AccessTokenInterface = Prisma.AccessTokenGetPayload<{ include: Record<keyof Prisma.AccessTokenInclude, true> }>;

@ObjectType()
export class AccessToken implements AccessTokenInterface {
    @Field(() => String, { description: 'The access token' })
    token: string;

    @Field(() => ID, { description: "The access token owner ID" })
    userId: string;

    @Field(() => GraphQLISODateTime, { description: 'The access token created at' })
    createdAt: Date;

    @Field(() => GraphQLISODateTime, { description: 'The access token expired at' })
    expiredAt: Date;

    @Field(() => GraphQLISODateTime, { description: "The access token refresh expired at" })
    refreshExpiredAt: Date;

    @Field(() => User, { description: "The access token woner" })
    user: UserInterface;
}