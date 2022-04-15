import { InputType, Int, Field } from '@nestjs/graphql';

@InputType()
export class CreateMomentInput {
  @Field(() => Int, { description: 'Example field (placeholder)' })
  exampleField: number;
}
