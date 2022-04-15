import {
  FactoryProvider,
  Inject,
  Injectable,
  OnModuleDestroy,
  OnModuleInit,
} from '@nestjs/common';
import { ConfigType } from '@nestjs/config';
import { PrismaClient } from '@prisma/client';
import { database } from './database.config';

@Injectable()
export class PrismaClientImpl
  extends PrismaClient
  implements OnModuleInit, OnModuleDestroy
{
  constructor(@Inject(database.KEY) { url }: ConfigType<typeof database>) {
    super({
      datasources: {
        db: { url },
      },
    });
  }

  /// On module init.
  onModuleInit: () => Promise<void> = () => this.$connect();

  /// On module destroy.
  onModuleDestroy: () => Promise<void> = () => this.$disconnect();

  static provider: FactoryProvider<PrismaClient> = {
    provide: PrismaClient,
    inject: [PrismaClientImpl],
    useFactory: (client: PrismaClientImpl) => client,
  };
}
