import { Field, InputType } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';
import { DateTimeFilter, StringFilter } from 'src/graphql';
import { UserProfileRelationFilter } from '../profiles/dto/user-profile-relation.filter';

@InputType()
export class UserWhereInput
  implements Omit<Prisma.UserWhereInput, 'accessTokens'>
{
  @Field(() => [UserWhereInput], {
    nullable: true,
    description: 'And where inputs',
  })
  AND?: Prisma.UserWhereInput[];

  @Field(() => [UserWhereInput], {
    nullable: true,
    description: 'Or where inputs',
  })
  OR?: Prisma.UserWhereInput[];

  @Field(() => [UserWhereInput], {
    nullable: true,
    description: 'Not where inputs',
  })
  NOT?: Prisma.UserWhereInput[];

  @Field(() => StringFilter, {
    nullable: true,
    description: 'Filter on the id column',
  })
  id?: StringFilter;

  @Field(() => StringFilter, {
    nullable: true,
    description: 'Filter on the name column',
  })
  name?: StringFilter;

  @Field(() => StringFilter, {
    nullable: true,
    description: 'Filter on the email column',
  })
  email?: StringFilter;

  @Field(() => StringFilter, {
    nullable: true,
    description: 'Filter on the phone column',
  })
  phone?: Prisma.StringFilter;

  @Field(() => DateTimeFilter, {
    nullable: true,
    description: 'Filter on the registeredAt column',
  })
  registeredAt?: Prisma.DateTimeFilter;

  @Field(() => UserProfileRelationFilter, {
    nullable: true,
    description: 'Filter on the profile relation',
  })
  profile?: Prisma.UserProfileRelationFilter;
}
