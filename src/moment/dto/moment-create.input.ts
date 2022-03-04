import { Field, InputType, PartialType, PickType } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';
import { Moment } from '../entities/moment.entity';

@InputType()
class MomentVideoMediaInput {
  @Field(() => String)
  poster: string;

  @Field(() => String)
  video: string;
}

@InputType()
export class MomentCreateInput
  extends PickType(
    PartialType(Moment),
    ['title', 'content'] as const,
    InputType,
  )
  implements Pick<Prisma.MomentCreateInput, 'title' | 'content'>
{
  @Field(() => [String], {
    nullable: true,
    description: 'Moment images media.',
  })
  images?: string[];

  @Field(() => MomentVideoMediaInput, {
    nullable: true,
    description: 'Moment video media.',
  })
  video?: MomentVideoMediaInput;
}
