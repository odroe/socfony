import { ArgsType, Field, registerEnumType } from "@nestjs/graphql";
import { UserFindUniqueInput } from "src/users/dto/user-find-unique.input";

export enum SignType {
    PASSWORD = "password",
    OTP = "otp",
}

registerEnumType(SignType, {
    name: "SignType",
    description: "Sign in type",
});

@ArgsType()
export class SignInArgument {
  @Field(() => UserFindUniqueInput, { description: "Find user where" })
  where: UserFindUniqueInput;

  @Field(() => String, { description: "The user password" })
  password: string;

  @Field(() => SignType, { description: "The sign in type" })
  type: SignType;
}