import { Field, Int, ObjectType } from '@nestjs/graphql';
import { LikeOnMoment, Prisma, StorageOnMoment, User } from '@prisma/client';
import { LikeOnMomentEntity } from './like_on_moment.entity';
import { UserEntity } from './user.entity';

@ObjectType({ description: 'Moment entity' })
export class MomentEntity
  implements
    Prisma.MomentGetPayload<{
      include: {
        storages: true;
        publisher: true;
        likers: true;
      };
    }>
{
  @Field(() => String, {
    description: 'The unique identifier for the moment.',
    nullable: false,
  })
  id: string;

  @Field(() => String, {
    description: 'The userId is moment publisher ID.',
    nullable: false,
  })
  publisherId: string;

  @Field(() => String, { description: 'The moment title.', nullable: true })
  title: string | null;

  @Field(() => String, { description: 'The moment content.', nullable: true })
  content: string | null;

  @Field(() => Date, { description: 'The moment created at.', nullable: false })
  createdAt: Date;

  /**
   * Storages
   */
  @Field(() => [String], {
    description: 'The moment storages.',
    nullable: 'items',
  })
  storages: StorageOnMoment[];

  /**
   * Publisher
   */
  @Field(() => UserEntity, {
    description: 'The moment publisher.',
    nullable: false,
  })
  publisher: User;

  /**
   * Likers count
   */
  @Field(() => Int, {
    description: 'The moment likers count.',
    nullable: false,
  })
  likersCount: number;

  /**
   * The moment likers
   */
  @Field(() => [LikeOnMomentEntity], {
    description: 'The moment likers.',
    nullable: false,
  })
  likers: LikeOnMoment[];
}
