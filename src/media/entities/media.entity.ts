import { Field, ObjectType } from '@nestjs/graphql';

@ObjectType()
export class Media {
  constructor(key: string) {
    this.key = key;
  }

  @Field(() => String)
  key: string;

  @Field(() => String)
  url!: string;
}
