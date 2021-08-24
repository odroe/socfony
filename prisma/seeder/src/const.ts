import { ConsoleLogger } from '@nestjs/common';

export const SEEDER = 'Seeder';

export const logger = new ConsoleLogger(SEEDER, { timestamp: true });
