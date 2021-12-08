import { Query, Resolver } from "@nestjs/graphql";
import { User } from "./entities/user.entity";

@Resolver(() => User)
export class UserResolver {
    @Query(() => User)
    async user() {}
}