import { InputType, PartialType, PickType } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';
import { UserEntity } from 'src/entities';

@InputType({ description: 'User where unique input.' })
export class UserWhereUniqueInput
  extends PartialType(
    PickType(UserEntity, ['id', 'username'] as const),
    InputType,
  )
  implements Prisma.UserWhereUniqueInput {}
