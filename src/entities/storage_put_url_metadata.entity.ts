import { Field, ObjectType } from '@nestjs/graphql';

@ObjectType()
export class StoragePutUrlMetadataEntity {
  @Field(() => String, { nullable: false, description: 'The storage id' })
  id: string;

  @Field(() => String, { nullable: false, description: 'HTTP put URL' })
  url: string;

  @Field(() => String, { nullable: false, description: 'HTTP put URL headers' })
  headers: string;
}
