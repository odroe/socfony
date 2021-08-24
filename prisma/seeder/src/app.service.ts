import { Injectable } from '@nestjs/common';
import { EventEmitter2 } from '@nestjs/event-emitter';
import { SEEDER } from './const';

@Injectable()
export class AppService {
  constructor(private readonly event: EventEmitter2) {}

  /**
   * Run the seeders.
   */
  run() {
    this.event.emit(SEEDER);
  }
}
