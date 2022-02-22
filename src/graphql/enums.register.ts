import { registerEnumType } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';

registerEnumType(Prisma.QueryMode, { name: 'QueryMode' });
registerEnumType(Prisma.SortOrder, { name: 'SortOrder' });
