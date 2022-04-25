import { Field, InputType } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';
import { DateTimeFilter, StringFilter } from 'src/filters';

@InputType({ description: 'Moment where input' })
export class MomentWhereInput implements Prisma.MomentWhereInput {
  /**
   * AND logical operator
   */
  @Field(() => [MomentWhereInput], {
    nullable: true,
    description: 'AND logical operator',
  })
  AND?: Prisma.MomentWhereInput[];

  /**
   * OR logical operator
   */
  @Field(() => [MomentWhereInput], {
    nullable: true,
    description: 'OR logical operator',
  })
  OR?: Prisma.MomentWhereInput[];

  /**
   * NOT logical operator
   */
  @Field(() => [MomentWhereInput], {
    nullable: true,
    description: 'NOT logical operator',
  })
  NOT?: Prisma.MomentWhereInput[];

  /**
   * id string filter
   */
  @Field(() => StringFilter, {
    nullable: true,
    description: 'id string filter',
  })
  id?: Prisma.StringFilter;

  /**
   * title string filter
   */
  @Field(() => StringFilter, {
    nullable: true,
    description: 'title string filter',
  })
  title?: Prisma.StringFilter;

  /**
   * content string filter
   */
  @Field(() => StringFilter, {
    nullable: true,
    description: 'content string filter',
  })
  content?: Prisma.StringFilter;

  /**
   * Publisher id
   */
  @Field(() => String, {
    nullable: true,
    description: 'Publisher id',
  })
  publisherId?: string;

  /**
   * Created at date filter
   */
  @Field(() => DateTimeFilter, {
    nullable: true,
    description: 'Created at date filter',
  })
  createdAt?: Prisma.DateTimeFilter;
}
