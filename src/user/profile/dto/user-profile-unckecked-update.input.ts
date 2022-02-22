import { Field, InputType, Int, registerEnumType } from '@nestjs/graphql';
import { Prisma, UserGender } from '@prisma/client';

registerEnumType(UserGender, { name: 'UserGender' });

@InputType()
export class UserProfileUncheckedUpdateInput
  implements Prisma.UserProfileUncheckedUpdateInput
{
  @Field(() => String, { nullable: true })
  bio?: string;

  @Field(() => UserGender, { nullable: true })
  gender?: UserGender;

  @Field(() => Int, { nullable: true })
  birthday?: number;
}
