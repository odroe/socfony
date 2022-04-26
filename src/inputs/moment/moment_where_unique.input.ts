import { InputType, PartialType, PickType } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';
import { MomentEntity } from 'src/entities';

@InputType({ description: 'Moment where unique input' })
export class MomentWhereUniqueInput
  extends PartialType(PickType(MomentEntity, ['id'] as const), InputType)
  implements Prisma.MomentWhereUniqueInput {}
