import { ArgsType, Field, Int } from '@nestjs/graphql';

@ArgsType()
export class PaginationArgs {
  /**
   * Sets the position for listing resource.
   */
  @Field(() => Int, {
    nullable: true,
    description: 'Sets the position for listing resource.',
    defaultValue: 15,
  })
  take: number = 15;

  /**
   * Skip the first `n` resources.
   */
  @Field(() => Int, {
    nullable: true,
    description: 'Skip the first `n` resources.',
    defaultValue: 0,
  })
  skip: number = 0;
}
