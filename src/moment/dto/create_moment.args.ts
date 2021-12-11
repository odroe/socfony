import { ArgsType, Field, InputType, PickType } from '@nestjs/graphql';
import { MultiMediaInput } from 'media/dto/multi_media.input';
import { Moment } from 'moment/entities/moment.entity';

/**
 * Create a new moment input.
 */
@ArgsType()
export class CreateMomentArgs extends PickType(
  Moment,
  ['body', 'title'] as const,
  ArgsType,
) {
  @Field(() => [MultiMediaInput], { nullable: 'itemsAndList' })
  media?: MultiMediaInput[];
}
