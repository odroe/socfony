import {
  GraphQLModule as _GraphQLModule,
  registerEnumType,
} from '@nestjs/graphql';
import { Prisma } from '@prisma/client';

export const GraphQLModule = _GraphQLModule.forRoot({
  autoSchemaFile: true,
  path: '/',
  sortSchema: true,
  fieldResolverEnhancers: ['guards'],
  buildSchemaOptions: {
    numberScalarMode: 'integer',
    dateScalarMode: 'isoDate',
  },
  context: ({ req }) => req,
});

// register sort Order enum
registerEnumType(Prisma.SortOrder, {
  name: 'SortOrder',
});
