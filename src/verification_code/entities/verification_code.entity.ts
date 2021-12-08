import { VerificationCode as $ } from '@prisma/client';
import { Field, ID, ObjectType } from "@nestjs/graphql";
import { DateTime } from 'graphql/scalars/date_time.scalar';

@ObjectType()
export class VerificationCode implements Pick<$, 'id' | 'expiredAt'> {
    @Field(() => ID)
    id: string;

    @Field(() => DateTime)
    expiredAt: Date;
}
