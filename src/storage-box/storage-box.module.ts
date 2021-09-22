import { DynamicModule, Inject, Module, FactoryProvider } from '@nestjs/common';
import { PrismaClient } from '@prisma/client';
import { StorageBox as _StorageBox, StorageBoxInterface } from 'storage-box';
import { StorageBoxPrismaDrive } from './prisma.drive';

const boxname = (name: string) => `storage-box://${name}`;

export const StorageBox = (name: string) => Inject(boxname(name));

@Module({})
export class StorageBoxModule {
  static box(name: string): DynamicModule {
    const provider: FactoryProvider = {
      provide: boxname(name),
      inject: [PrismaClient],
      useFactory: (prisma: PrismaClient) =>
        new _StorageBox(
          name,
          (box: StorageBoxInterface) => new StorageBoxPrismaDrive(prisma, box),
        ),
    };

    return {
      module: StorageBoxModule,
      providers: [provider],
      exports: [provider],
    };
  }
}
