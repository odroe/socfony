import { ArgsType, PartialType, PickType } from '@nestjs/graphql';
import { UserProfileEntity } from 'src/entities';

@ArgsType()
export class UpdateUserProfileArgs extends PartialType(
  PickType(UserProfileEntity, ['bio', 'birthday', 'gender'] as const),
  ArgsType,
) {}
