# @socfony/prisma

Prisma ORM binding for NestJS.

## Installation

```bash
npm i @socfony/prisma
```

If you are using Yarn:

```bash
yarn add @socfony/prisma
```

## Usage

```ts
import { PrismaModule } from '@socfony/prisma';

@Module({
    imports: [PrismaModule.forRoot()],
})
export class AppModule {}
```

## Options

 - `client`: If you customize the Prisma output, you can customize the import PrismaClient class, which is imported from `@prisma/client` by default.
 - `{...options}`, [see PrismaClient options](https://www.prisma.io/docs/reference/api-reference/prisma-client-reference#prismaclient)

 ### Custom PrismaClient

 ```ts
 import { PrismaClient } from './prisma-client';

 @Module({
     imports: [PrismaModule.forRoot({
         client: PrismaClient,
         /// More Prisma client options
     })],
 })
 export class AppModule {}
 ```

 ### PrismaClient options in `forRoot`/`forAsyncRoot`

 ```ts
 import { PrismaModule } from '@socfony/prisma';

 @Module({
     imports: [
         PrismaModule.forRoot({
             // client: PrismaClient, // If you custom Prisma ouput, you can customize the import PrismaClient class, which is imported from `@prisma/client` by default.`
             log: ['info', 'error'],
             // Other Prisma client options
         }),
     ],
 })
 export class AppModule {}
 ```

 ### Async

 ```ts
 import { PrismaModule } from '@socfony/prisma';
 
 @Module({
     imports: [PrismaModule.forAsyncRoot({
         useFactory: async () => {
             // Custom code.
             return {/* ...Options */}
         },
     })],
 })
 export class AppModule {}
 ```

## License

BSD 3-Clause License.

Copyright (c) 2021, [Odroe Inc.](https://odroe.com)
All rights reserved.
