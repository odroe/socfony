import { InputType, PickType } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';
import { CommentEntity } from 'src/entities';

@InputType({ description: 'Comment where unique input' })
export class CommentWhereUniqueInput
  extends PickType(CommentEntity, ['id'] as const, InputType)
  implements Prisma.CommentWhereUniqueInput {}
