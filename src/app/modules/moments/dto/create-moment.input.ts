import { InputType, PickType } from '@nestjs/graphql';
import { Moment } from '../entities/moment.entity';

@InputType()
export class CreateMomentInput extends PickType(
  Moment,
  ['title', 'content', 'storages'] as const,
  InputType,
) {}
