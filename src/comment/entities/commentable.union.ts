import { createUnionType } from '@nestjs/graphql';
import { Moment } from 'src/moment/entities/moment.entity';

export const Commentable = createUnionType({
  name: 'Commentable',
  types: () => [Moment] as const,
  resolveType: () => Moment,
});
