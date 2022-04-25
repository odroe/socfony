import { ArgsType, PartialType, PickType } from '@nestjs/graphql';
import { MomentEntity } from 'src/entities';

@ArgsType()
export class CreateMomentArgs extends PartialType(
  PickType(MomentEntity, ['content', 'title', 'storages'] as const),
  ArgsType,
) {}
