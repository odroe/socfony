import { ClassProvider, Type, OnModuleDestroy, OnModuleInit, Inject } from "@nestjs/common";
import { getPrismaClient, PrismaClientOptions } from '@prisma/client/runtime';

export type PrismaClientInterface = Pick<InstanceType<ReturnType<typeof getPrismaClient>>, '$connect' | '$disconnect'>;

export const PRISMA_MODULE_OPTIONS = 'socfony|Prisma module options';

export function prismaProviderFactory<T extends PrismaClientInterface = PrismaClientInterface>(className: Type<T>): ClassProvider<T> {
    // @ts-ignore
    class service extends className implements OnModuleInit, OnModuleDestroy {
        constructor(@Inject(PRISMA_MODULE_OPTIONS) options: PrismaClientOptions) {
            super(options);
        }

        async onModuleInit() {
            await this.$connect();
        }

        async onModuleDestroy() {
            await this.$disconnect();
        }
    }

    return {
        provide: className,
        useClass: service as any,
    };
}
