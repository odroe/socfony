import { InputType, PartialType, PickType } from "@nestjs/graphql";
import { User } from "../entities/user.entity";

const BaseInput = PickType(PartialType(User), <const>['id', 'email', 'mobile', 'name'], InputType);

@InputType()
export class UserFindUniqueInput extends BaseInput {}