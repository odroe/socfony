import { DynamicModule, FactoryProvider, Module, ModuleMetadata, Type } from '@nestjs/common';
import { PrismaClientOptions } from '@prisma/client/runtime';
import { prismaProviderFactory, PrismaClientInterface, PRISMA_MODULE_OPTIONS } from './prisma.provider';

export type PrismaOptions<T> = {
    /**
     * Prisma client class.
     * 
     */
    client?: Type<T>;
} & PrismaClientOptions;

export type PrismaModuleAsyncOptions<T extends PrismaClientInterface> = Pick<ModuleMetadata, 'imports'> & Pick<Partial<FactoryProvider<PrismaClientOptions | Promise<PrismaClientOptions>>>, 'useFactory' | 'inject'> & Pick<PrismaOptions<T>, 'client'>;

function resolveClient<T extends PrismaClientInterface>(client?: Type<T>): Type<T> {
    if (client && typeof client === 'function') {
        return client;
    }

    const internal = require('@prisma/client').PrismaClient;
    if (!internal) {
        throw new Error('Prisma client not found');
    }

    return internal;
} 

@Module({})
export class PrismaModule {
    static forRoot<T extends PrismaClientInterface>(options?: PrismaOptions<T>): DynamicModule {
        const { client, ...args } = options || {};
        const __internal = resolveClient(client);

        const provider = prismaProviderFactory(__internal);
        const optionsProvider = {
            provide: PRISMA_MODULE_OPTIONS,
            useValue: args,
        };

        return {
            global: true,
            module: PrismaModule,
            providers: [optionsProvider, provider],
            exports: [provider],
        };
    }

    static forRootAsync<T extends PrismaClientInterface>(options?: PrismaModuleAsyncOptions<T>): DynamicModule {
        const { client, inject, useFactory, imports } = options || {};

        const __internal = resolveClient(client);
        const provider = prismaProviderFactory(__internal);
        const optionsProvider: FactoryProvider<PrismaClientOptions | Promise<PrismaClientOptions>> = {
            provide: PRISMA_MODULE_OPTIONS,
            inject: inject,
            async useFactory(...args: any[]) {
                if (useFactory && typeof useFactory === 'function') {
                    return await useFactory(...args);
                }

                return {};
            },
        };

        return {
            global: true,
            module: PrismaModule,
            imports: imports,
            providers: [optionsProvider, provider],
            exports: [provider],
        };
    }
}
