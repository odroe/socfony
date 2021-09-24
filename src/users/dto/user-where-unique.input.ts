import { InputType, PartialType, PickType } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';
import { User } from '../entities/user.entity';

@InputType()
export class UserWhereUniqueInput
  extends PickType(
    PartialType(User),
    <const>['id', 'name', 'email', 'phone'],
    InputType,
  )
  implements Prisma.UserWhereUniqueInput {}
